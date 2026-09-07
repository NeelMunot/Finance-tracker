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

## How to add an ADR
For a meaningful architectural change, add:
- Decision
- Status
- Context
- Alternatives considered
- Consequences
- Date
