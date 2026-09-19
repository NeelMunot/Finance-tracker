# Development State

Last updated: 2026-09-19

## Current phase
Phase 2 — Authentication complete; Phase 3 is next.

## Completed
- Product architecture baseline documented.
- AI-agent context structure defined.
- MCP strategy defined (filesystem, GitHub, Context7).
- Core architectural constraints documented.
- Foundational data decisions locked in: no Account/balance entity (ADR-008), integer
  minor-unit amounts (ADR-009), UUID/epoch-ms IDs & timestamps (ADR-010), SQLCipher
  local encryption (ADR-011), Firebase App Check from Phase 2 (ADR-012).
- `docs/data-model.md` rewritten with concrete v1 field types (no longer "fields may
  include" placeholders).
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
- Manual Firebase Console setup and local App Check debug-token registration.

## Next
1. Implement Drift schema (encrypted) per `docs/data-model.md` v1 (Phase 3).
2. Implement transaction domain / use cases (Phase 4).
3. Implement categories/payment methods.
4. Implement repositories.
5. Add core transaction UI.
6. Implement credit cards (liability computed, per `.github/skills/credit-card-logic-review`).
7. Implement sync.

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
