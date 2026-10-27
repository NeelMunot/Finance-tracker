# Development Changelog

## 2026-10-27
- Implemented Phase 3 Slice 1 (Encrypted Database Foundation):
  - Configured SQLCipher native build hooks (`hooks.user_defines.sqlite3.source: sqlcipher`) with `package:sqlite3: ^3.8.0` and `drift: ^2.35.3` / `drift_dev: ^2.35.2`.
  - Upgraded to `flutter_secure_storage: ^11.2.0` with `AndroidOptions(storageNamespace: 'finance_tracker_vault')` to support isolated secure storage namespaces without deprecated flags.
  - Implemented `DatabaseKeyManager` domain contract and `SecureStorageDatabaseKeyManager` to securely generate, persist, and retrieve 256-bit AES encryption keys per user. User IDs are sanitized to filesystem-safe SHA-256 hashes (`app_user_<hash>.db`), and keys are never logged or exposed in exceptions.
  - Added in-memory `FakeDatabaseKeyManager` to enable fake-backed unit testing without platform channels or real Keystore access.
  - Implemented `EncryptedDatabaseFactory` and `AppDatabase` with fail-closed runtime security verification: verifies `PRAGMA cipher_version;`, enforces 256-bit hexadecimal keys via `PRAGMA key = "x'<hex>'";`, verifies decryption via `SELECT count(*) FROM sqlite_master;`, and prevents plaintext SQLite fallback.
  - Wired `appDatabaseProvider` into Riverpod scoped to `requiredUserScopeProvider`, ensuring user-scoped database isolation and proper disposal on sign-out without deleting user keys or data.
  - Configured Android backup exclusion XML rules (`backup_rules.xml` and `data_extraction_rules.xml`) and referenced them in `AndroidManifest.xml` to prevent Keystore-bound encrypted databases from being corrupted across device backups. Updated rules to explicitly exclude `<exclude domain="root" path="app_flutter" />` matching `getApplicationDocumentsDirectory()`.
  - Added unit test suites verifying key management and encrypted database lifecycle (21 tests passing).
  - Executed Android emulator runtime integration test suite (`integration_test/encrypted_database_android_test.dart`) on Android 16 (API 36) verifying active SQLCipher 4.19.0 community runtime, database creation, reopen with correct key, fail-closed failure with incorrect key, unkeyed access failure, and verified unencrypted `/system/bin/sqlite3` failure (`file is not a database (26)`).
- Completed Phase 3 architecture review and baseline refinement:
  - Added ADR-013 establishing per-user local database isolation (`app_user_<hash>.db`) with independent secure-storage keys, lifecycle tied to `UserScope`, and OS auto-backup exclusion.
  - Added ADR-014 establishing uniform soft-delete (`deletedAt`) and synchronization metadata (`createdAt`, `updatedAt`, `deletedAt`, `syncStatus`, `version`) across all 5 mutable entities (`Category`, `PaymentMethod`, `CreditCard`, `Transaction`, `Attachment`).
  - Added ADR-015 establishing credit-card privacy rules and non-credential profile model (PAN, CVV/CVC, PINs strictly prohibited; profile-only tracking; schema-only `CreditCard` table in Phase 3; logic deferred to Phase 5).
  - Modernized database encryption plan: Adopted `package:sqlite3` 3.x build hooks (`hooks.user_defines.sqlite3.source: sqlcipher`) with Drift (>= 2.32.0) for native SQLCipher bundling, retiring obsolete `sqlcipher_flutter_libs`.
  - Updated `docs/requirements.md`, `docs/data-model.md`, `docs/roadmap.md`, `docs/development-state.md`, and `docs/decisions.md`.

## 2026-09-19
- Implemented Phase 2 authentication foundation: Firebase initialization, Android
  Google Services integration, Firebase App Check debug provider, Google Sign-In,
  Firebase Auth state handling, auth-aware routing, and authenticated user scope
  guards.
- Added fake-backed auth state and routing tests without live Firebase services.
- Kept local `android/app/google-services.json` out of Git tracking.
- Android debug validation reached `assembleDebug` but was terminated during the
  first-time SDK/Gradle setup.

## 2026-09-08
- Initialized the Android-only Flutter project for Phase 1.
- Added Riverpod state management, go_router navigation, layered source folders,
  placeholder theme, centralized error handling/logging, environment configuration,
  and a foundation widget smoke test.
- Phase 1 checkpoint passed: `flutter analyze` reported no issues and `flutter test`
  passed with 1 test. Android debug build remains blocked by first-time Gradle setup
  stalling at `assembleDebug`.

## 2026-09-08
- Locked v1 scope decision: no Account/bank-balance entity (ADR-008); PaymentMethod is
  a label only; credit-card liability is computed, not stored.
- Locked money/ID/timestamp representation (ADR-009, ADR-010) and rewrote
  `docs/data-model.md` with concrete v1 field types.
- Added local DB encryption decision (SQLCipher, ADR-011).
- Added Firebase App Check to Phase 2 of the roadmap, ahead of its Nov 2026
  enforcement deadline for Firebase AI Logic (ADR-012).
- Split `.github/copilot-instructions.md` into a slim core file plus scoped
  `.github/instructions/*.instructions.md` files, and added three `.github/skills/`
  entries (add-domain-usecase, add-drift-migration, credit-card-logic-review).
- Fixed `.vscode/mcp.json` filesystem server to be cross-platform by default.

## 2026-09-05
- Created repository AI-context structure.
- Defined baseline project architecture.
- Defined durable AI-memory strategy.
- Defined MCP integration strategy.
