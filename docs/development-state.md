# Development State

Last updated: 2026-10-27

## Current phase
Phase 3 — Local Database: Slice 1 (Encrypted Database Foundation) complete. Waiting for review before implementing Slice 2 (Schema & entity tables).

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
- Comprehensive unit test suites implemented (`test/security/database_key_manager_test.dart` and
  `test/database/encrypted_database_test.dart`) covering key generation, retrieval persistence, corruption
  handling, SQLCipher runtime availability, reopening, wrong-key failure, and unencrypted-read rejection.
- On-device Android integration test suite (`integration_test/encrypted_database_android_test.dart`) executed
  successfully on Android 16 (API 36) emulator: verified runtime SQLCipher 4.19.0 community active, verified
  encrypted DB creation in `/data/user/0/<package>/app_flutter/`, verified successful reopen with key, verified
  fail-closed rejection with wrong key, verified rejection without key, and verified unencrypted `/system/bin/sqlite3`
  fails with `file is not a database (26)`.
- Corrected Android backup rules (`backup_rules.xml` and `data_extraction_rules.xml`) to explicitly exclude
  `<exclude domain="root" path="app_flutter" />` because `getApplicationDocumentsDirectory()` resolves to
  `/data/user/0/<package>/app_flutter/` which is under Android's `root` domain, not `database`.
- `docs/data-model.md` and `docs/requirements.md` updated to reflect concrete schema and privacy baseline.
- Copilot instructions split into a slim repository-wide file plus path-scoped
  `.github/instructions/*.instructions.md` files (domain, data, credit-card) and
  three reusable `.github/skills/` entries.
- Android-only Flutter project initialized with Riverpod, go_router, layered
  source structure, placeholder theme, error handling, logging, environment
  configuration, and a foundation smoke test.
- Firebase Core, Firebase Auth, Firebase App Check debug-provider bootstrap, and
  Google Sign-In integrated behind infrastructure/application abstractions.
- Authentication loading, signed-out, signed-in, and error states are modeled
  and connected to routing.
- Authenticated user scope and a repository access guard are established for
  future repositories without adding persistence.

## In progress
- Phase 3 Slice 1 review checkpoint.

## Next (Phase 3 Slice 2 — Schema & Entity Tables)
1. Define Drift tables (`Categories`, `PaymentMethods`, `CreditCards`, `Transactions`, `Attachments`) with the common `SyncableTable` mixin per `docs/data-model.md`.
2. Implement schema v1 migrations and relations (e.g. `PaymentMethod.linkedCreditCardId` foreign key to `CreditCards.id`).
3. Run code generation (`build_runner`) for the complete entity schema.
4. Implement repositories and test suite (schema creation, referential integrity, soft-delete filtering).
5. Run static analysis and unit tests (`flutter analyze`, `flutter test`).

## Known issues
- Android debug build completed successfully on 2026-10-27 (`build\app\outputs\flutter-apk\app-debug.apk`) with SQLCipher native libraries bundled; first-time SDK/CMake 3.22.1 installation completed.
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
