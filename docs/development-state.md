# Development State

Last updated: 2026-10-31

## Current phase
Phase 3 — Local Database: Complete (Slice 1 Encrypted Foundation & Slice 2 Schema/Entity Tables). Ready for review before proceeding to Phase 4 (Transactions).

## Completed
- Product architecture baseline documented.
- AI-agent context structure defined.
- MCP strategy defined (filesystem, GitHub, Context7).
- Core architectural constraints documented.
- Foundational data decisions locked in: no Account/balance entity (ADR-008), integer
  minor-unit amounts (ADR-009), UUID/epoch-ms IDs & timestamps (ADR-010), SQLCipher
  local encryption (ADR-011), Firebase App Check from Phase 2 (ADR-012).
- Per-user local database isolation and lifecycle documented (ADR-013): one encrypted
  Drift database per authenticated user (`app_user_<hash>.db`), unique secure storage keys,
  lifecycle tied to `UserScope`, fail-closed verification, and OS auto-backup exclusion.
- Uniform persistence and synchronization metadata locked in across all 5 syncable entities
  (ADR-014): `createdAt`, `updatedAt`, `deletedAt`, `syncStatus`, `version`.
- Credit-card privacy and non-credential profile model documented (ADR-015): PAN, CVV,
  PINs prohibited; profile-only metadata; `CreditCard` table created in Phase 3 as
  schema-only infrastructure with domain logic deferred to Phase 5.
- Modern SQLCipher dependency plan resolved: Native bundling via `package:sqlite3` 3.x build
  hooks (`hooks.user_defines.sqlite3.source: sqlcipher`) with Drift (>= 2.32.0, using `^2.35.3`),
  retiring obsolete `sqlcipher_flutter_libs`.
- Android backup exclusion rules (`res/xml/backup_rules.xml` and `res/xml/data_extraction_rules.xml`)
  created and explicitly wired into `AndroidManifest.xml` (`android:fullBackupContent` and
  `android:dataExtractionRules`) to prevent device-bound Keystore disconnects.
- `DatabaseKeyManager` abstract interface and `SecureStorageDatabaseKeyManager` implemented with
  `flutter_secure_storage: ^11.2.0` (`storageNamespace: 'finance_tracker_vault'`), generating 256-bit
  cryptographically secure keys per user, sanitizing user IDs via SHA-256 (`app_user_<hash>.db`),
  strictly validating format, and preventing key leakage in logs or exceptions.
- `EncryptedDatabaseFactory` implemented with fail-closed runtime checks: enforces active SQLCipher
  binary (`PRAGMA cipher_version;`), applies 256-bit keys via `PRAGMA key = "x'<hex>'";`, verifies
  readability via `SELECT count(*) FROM sqlite_master;`, and strictly blocks plaintext SQLite fallback.
- Drift `AppDatabase` foundation instantiated and wired into Riverpod (`appDatabaseProvider`) scoped to
  `requiredUserScopeProvider` with lifecycle disposal on sign-out.
- Initial Schema Version 1 defined and generated for all five entities:
  - `Categories`: root income/expense taxonomy with `CategoryType` (`INCOME`/`EXPENSE`).
  - `CreditCards`: non-credential tracking profile with 4-digit numeric validation (`GLOB '[0-9][0-9][0-9][0-9]'`), statement day & due day range (1–31), and non-negative credit limit.
  - `PaymentMethods`: plain label table with no balance column (ADR-008), with `linkedCreditCardId` foreign key (`ON DELETE SET NULL`).
  - `Transactions`: mutable transaction record with strictly positive amount minor units (`CHECK (amount_minor_units > 0)`), 3-uppercase-ASCII currency code format (`CHECK (currency GLOB '[A-Z][A-Z][A-Z]')`), foreign keys to Category (`RESTRICT`) and PaymentMethod (`RESTRICT`), and default source `MANUAL`.
  - `Attachments`: receipt/document metadata with foreign key to Transaction (`ON DELETE CASCADE` for physical row deletion; soft-deletions handled by domain layer) and nullable `AiProcessingStatus`.
  - `SyncableTable`: uniform persistence mixin across all 5 tables (`createdAt`, `updatedAt`, `deletedAt`, `syncStatus`, `version`).
- Explicit Drift `TypeConverter` implementations for all domain and sync enums storing exact uppercase strings (`INCOME`, `EXPENSE`, `CASH`, `BANK`, `CREDIT_CARD`, `WALLET`, `OTHER`, `TRANSFER`, `MANUAL`, `AI_RECEIPT`, `AI_NATURAL_LANGUAGE`, `CSV_IMPORT`, `NOT_PROCESSED`, `PENDING`, `DONE`, `FAILED`) and lowercase sync status (`pending`, `synced`, `conflict`), failing closed with `ArgumentError` on unknown values.
- Schema v1 snapshot exported and checked into Git (`drift_schemas/drift_schema_v1.json`).
- Comprehensive schema unit test suite implemented (`test/database/schema_v1_test.dart`) covering table structure, uniform metadata, archive indicators, enum serialization/deserialization, default value emission, SQLite-level DDL constraint enforcement (positive amount, currency GLOB, statement/due day, credit limit, 4-digit card number), NOT NULL constraint enforcement, foreign key actions (`SET NULL`, `RESTRICT`, `CASCADE`), SQLCipher encryption at rest, and user database isolation (38/38 unit/widget tests passing).

## In progress
- Phase 3 completion checkpoint.

## Next (Phase 4 — Transactions)
1. Define Transaction domain entities, value objects (`Money`, `Currency`), and validation rules.
2. Implement transaction repository interface and Drift repository implementation.
3. Centralize transaction mutation use cases (`CreateTransactionUseCase`, `UpdateTransactionUseCase`, `DeleteTransactionUseCase` with attachment soft-delete cascading).
4. Implement transaction queries (filtering, search, pagination).
5. Build presentation layer for transaction creation, editing, and list display.

## Known issues
- Local `android/app/google-services.json` is required and ignored by Git; it must
  be supplied from the existing Firebase project configuration.
- Firebase Console must have Google provider enabled and the generated App Check
  debug token registered after the first local run.
- Android emulator integration tests passed 6/6 tests on Android 16 (API 36) on 2026-10-27.
- `flutter analyze` passed with no issues on 2026-10-27.
- `flutter test` passed with 21 unit/widget tests on 2026-10-27.
- Local `android/app/google-services.json` is required and ignored by Git; it must
  be supplied from the existing Firebase project configuration.
- Firebase Console must have Google provider enabled and the generated App Check
  debug token registered after the first local run.

## Deferred (see `docs/roadmap.md` "Deferred / Not Scheduled")
- Bank-account balance tracking (only if v1 usage shows it's actually needed).
- Recurring transactions.
- Full investment tracking.
- Android App Functions / on-device agent integration (platform still in preview).
- Advanced portfolio analytics.
- Automated UI testing with Playwright.

## Agent notes
Update this file after meaningful implementation work. Prefer concise dated updates.
Before starting a new session's work, re-read this file plus `docs/decisions.md` —
do not rely on prior chat history as the source of truth.
