# Development State

Last updated: 2026-10-27

## Current phase
Phase 2 — Authentication complete. Phase 3 (Local Database) architecture review approved; implementation ready to begin upon approval.

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
  hooks (`hooks.user_defines.sqlite3.source: sqlcipher`) with Drift (>= 2.32.0, recommended `^2.35.3`),
  replacing obsolete `sqlcipher_flutter_libs`.
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
- Manual Firebase Console setup and local App Check debug-token registration on device/emulator.

## Next (Phase 3 Implementation — Pending Approval)
1. Add Phase 3 dependencies to `pubspec.yaml`: Drift (>= 2.32.0, e.g. `drift: ^2.35.3`, `drift_dev: ^2.35.3`), `package:sqlite3` 3.x (`sqlite3: ^3.1.0`) configured with native build hooks (`hooks.user_defines.sqlite3.source: sqlcipher`), `flutter_secure_storage: ^10.0.0`, `uuid: ^4.5.1`, `crypto: ^3.0.6`, `path_provider: ^2.1.5`, `path: ^1.9.1`.
2. Configure Android backup rules (`res/xml/backup_rules.xml` and `data_extraction_rules.xml`) AND update `AndroidManifest.xml` (`android:fullBackupContent` and `android:dataExtractionRules` attributes on `<application>`) to explicitly activate backup exclusion for local encrypted database files and secure-storage preferences.
3. Implement `DatabaseKeyManager` in `lib/infrastructure/security/` to safely generate/retrieve 256-bit keys per `UserScope` using modern `flutter_secure_storage` namespace isolation.
4. Define Drift tables (`Categories`, `PaymentMethods`, `CreditCards`, `Transactions`, `Attachments`) with the common `SyncableTable` mixin per `docs/data-model.md`.
5. Implement user-scoped encrypted Drift database class with fail-closed SQLCipher initialization and sanitized database paths (`app_user_<hash>.db`).
6. Wire `databaseProvider` into Riverpod scoped to `requiredUserScopeProvider` with lifecycle disposal on sign-out. Testing will use fake repositories and Riverpod provider overrides; no runtime development-mode authentication bypass will be used.
7. Run code generation (`build_runner`) and implement verification tests (schema creation, fail-closed encryption verification, user isolation, and soft-delete filtering).
8. Run static analysis and unit tests (`flutter analyze`, `flutter test`).

## Known issues
- Android debug build stalled during first-time Gradle setup at `assembleDebug`.
- Android debug build was retried after Firebase Gradle integration and remained
  at `assembleDebug` until the terminal process was terminated.
- `flutter analyze` passed with no issues on 2026-09-19.
- `flutter test` passed with 3 tests on 2026-09-19.
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
