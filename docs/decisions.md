# Architecture Decision Record

## ADR-001 — Local database
Status: Accepted

Decision:
Use Drift/SQLite as the operational local database.

Reason:
The application is transaction-heavy, offline-first, and requires relational queries.

## ADR-002 — Firestore role
Status: Accepted

Decision:
Use Firestore for cloud persistence/synchronization rather than as the sole operational database.

## ADR-003 — Centralized transaction mutations
Status: Accepted

Decision:
All transaction creation/update/deletion flows pass through centralized business logic.

Reason:
Manual entry, AI entry, receipt extraction and imports must enforce identical rules.

## ADR-004 — AI access
Status: Accepted

Decision:
AI integrations never receive unrestricted database write access.

Reason:
AI output is probabilistic/untrusted and must pass validation and authorization.

## ADR-005 — Receipt workflow
Status: Accepted

Decision:
Receipt analysis is optional; receipt files can be stored independently of AI processing.

## ADR-006 — Credit-card accounting
Status: Accepted

Decision:
Credit-card purchases remain categorized expenses while separately affecting card liability. Bill payments reduce liability without duplicating expenses.

## ADR-007 — Project memory
Status: Accepted

Decision:
Repository documentation is durable project memory. MCP servers provide access to the project context rather than being the sole memory store.

## ADR-008 — No account/bank-balance entity in v1
Status: Accepted

Decision:
The application will not model bank accounts or account balances in v1. `PaymentMethod` is a plain label with no balance. `Transaction.type = TRANSFER` exists solely to represent credit-card bill payments (moving a payment from a bank/cash label to a credit-card label), not general account-to-account transfers.

Reason:
The user's goal for v1 is fast transaction logging, not a full ledger with reconciled account balances. Credit-card liability (a hard requirement) is achieved without a generic Account entity — see the credit-card liability calculation in `data-model.md`.

Consequences:
If real bank-account balance tracking is wanted later, it is a deliberate v2 feature (new `Account` entity, migration, and reconciliation logic), not something retrofitted onto `TRANSFER`.

## ADR-009 — Money representation
Status: Accepted

Decision:
All monetary amounts are stored as signed 64-bit integers in minor currency units (e.g. paise, cents), never as floating point. A `currency` (ISO 4217) field always travels alongside an amount.

Reason:
Floating-point arithmetic on money produces rounding errors; this is a correctness requirement for a finance app, not a style preference.

## ADR-010 — ID and timestamp strategy
Status: Accepted

Decision:
Entity IDs are client-generated UUIDv4 strings, not auto-increment integers. Timestamps are stored as UTC epoch milliseconds; `transactionDate` (user-meaningful date/time) is tracked separately from `createdAt`/`updatedAt` (record bookkeeping).

Reason:
Client-generated IDs and UTC timestamps are required for offline-first creation and conflict-free synchronization with Firestore.

## ADR-011 — Local database encryption
Status: Accepted

Decision:
The local Drift/SQLite database is encrypted via SQLCipher from the point it is first introduced (Phase 3), with the encryption key stored in platform secure storage (Android Keystore via `flutter_secure_storage`), not deferred to a later hardening phase.

Reason:
This is financial data at rest on a personal device. Adding encryption after the app has shipped with an unencrypted database requires a disruptive migrate-and-re-encrypt step for existing users; deciding it up front avoids that.

## ADR-012 — Firebase App Check from Phase 2
Status: Accepted

Decision:
Firebase App Check is configured alongside Authentication in Phase 2, not deferred to a later security-hardening phase.

Reason:
Firebase has confirmed App Check enforcement becomes required for Firebase AI Logic starting November 2, 2026. Given the expected development timeline, treating this as day-one plumbing avoids a hard stop later.

## ADR-013 — Per-user local database isolation & lifecycle
Status: Accepted
Date: 2026-10-27

Decision:
Each authenticated Firebase user is allocated an isolated, SQLCipher-encrypted Drift SQLite database file (`app_user_<hash>.db`), where `<hash>` is a filesystem-safe SHA-256 hash prefix of the authenticated `userId`. Tables inside the database do not contain redundant `userId` columns.

Lifecycle & Key Management:
- A database may open only after authentication successfully resolves to a signed-in `UserScope`.
- Each user's database uses an independent 256-bit encryption key stored in platform secure storage (`flutter_secure_storage`).
- On sign-out, the user-scoped database connection and Riverpod providers are closed and disposed.
- Database files and secure-storage keys are **not** automatically deleted on sign-out; local data retention ensures offline availability upon re-authentication. Explicit data wipe is a distinct, destructive operation.
- Verification & Fail-Closed: SQLCipher initialization verifies cipher presence and validity. If an encrypted database cannot be opened, the application fails closed; no plaintext SQLite fallback is permitted.
- Backup & Restore Policy: Local database files and secure-storage preferences are explicitly excluded from Android Auto Backup. Hardware Keystore keys are device-bound and cannot be restored across devices or reinstalls; cross-device data restoration is handled exclusively via Cloud Firestore synchronization (Phase 6).

Alternatives considered:
- Single shared database with `userId` column on every entity table: Rejected due to risk of cross-user data leakage if any query omits `WHERE userId = ...`, excessive compound indexing overhead, and complicated data purging.

Consequences:
- Cryptographic and physical isolation of user financial data at rest.
- Clean integration with Riverpod `requiredUserScopeProvider`.
- Table schemas and query logic remain uncluttered by tenant filtering.

## ADR-014 — Uniform soft-delete and synchronization metadata
Status: Accepted
Date: 2026-10-27

Decision:
All five mutable, syncable entities — `Category`, `PaymentMethod`, `CreditCard`, `Transaction`, and `Attachment` — uniformly implement common persistence and synchronization metadata in Drift schema v1:
- `createdAt` (integer, UTC epoch ms, non-nullable)
- `updatedAt` (integer, UTC epoch ms, non-nullable)
- `deletedAt` (integer, UTC epoch ms, nullable tombstone)
- `syncStatus` (text/enum: `pending`, `synced`, `conflict`, default `'pending'`)
- `version` (integer, local mutation counter, default `1`)

`active: bool` on `Category`, `PaymentMethod`, and `CreditCard` remains distinct from `deletedAt`: `active = false` is a user-facing archive toggle that hides the entity from selection pickers while preserving historical transactions; `deletedAt != null` is a soft-delete tombstone that excludes the row from normal queries and informs Phase 6 synchronization of deletions.

Scope boundary:
The schema defines these columns in Phase 3. The synchronization engine and conflict resolution logic remain deferred to Phase 6.

Alternatives considered:
- Physical row deletion (`DELETE FROM`) in Phase 3: Rejected because offline deletions could not be tracked or propagated to Cloud Firestore in Phase 6 without a disruptive schema migration.
- Only adding sync columns to `Transaction`: Rejected because categories, payment methods, cards, and attachments are all user-created mutable entities requiring cloud sync.

Consequences:
- Eliminates schema migrations when Phase 6 Cloud Sync is introduced.
- Default repository queries must filter out records where `deletedAt != null`.

## ADR-015 — Credit-card privacy & non-credential profile model
Status: Accepted
Date: 2026-10-27

Decision:
The `CreditCard` entity is strictly a personal financial tracking profile for billing schedules and liability calculations, not a payment credential, token, or processing instrument.

Privacy & Security Constraints:
1. The application strictly prohibits collecting or storing Primary Account Numbers (full PAN), Card Verification Values (CVV/CVC), PINs, OTPs, or online banking credentials. CVV/CVC must never be stored under any circumstances.
2. Card profiles focus exclusively on user-defined tracking metadata: nickname, issuer, statement closing day (1–31), payment due day (1–31), billing-cycle rules, and optional credit limit. (Reminder preferences are deferred from the v1 schema until a dedicated notification feature is designed).
3. An optional `lastFourDigits` field is supported solely for user display and distinguishing cards; it must never be required.
4. Creating a credit-card profile is entirely optional; the application is fully usable with standard payment-method labels (cash, bank, wallet) without entering any credit-card profile.
5. Local SQLCipher encryption is mandatory, but encryption is never used as justification for collecting unnecessary sensitive payment credentials.
6. The `CreditCard` table is provisioned in Phase 3 as schema-only infrastructure (enabling referential integrity for `PaymentMethod.linkedCreditCardId`). All credit-card domain logic, billing-cycle math, liability queries, and UI are deferred to Phase 5.
7. Any future proposal to store full card numbers would require an independent product and security decision with a formal threat model and security review; it is not permitted implicitly in v1.

Alternatives considered:
- Deferring the `CreditCard` table to Phase 5: Rejected because `PaymentMethod.linkedCreditCardId` requires a valid relational foreign key in Schema v1 to avoid schema alteration in Phase 5.
- Collecting card numbers for auto-formatting: Rejected to minimize attack surface and compliance burden.

Consequences:
- Avoiding payment-credential storage significantly reduces exposure and attack surface, but does not eliminate all security, privacy, or compliance obligations (personal financial metadata remains sensitive and requires robust protection).
- Users have full privacy and control over card tracking.

## How to add an ADR
For a meaningful architectural change, add:
- Decision
- Status
- Context
- Alternatives considered
- Consequences
- Date
