# Development State

Last updated: 2026-09-08

## Current phase
Phase 1 — Project Foundation complete; Phase 2 is next.

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

## In progress
- None.

## Next
1. Configure authentication + Firebase App Check together (Phase 2).
2. Implement Drift schema (encrypted) per `docs/data-model.md` v1 (Phase 3).
3. Implement transaction domain / use cases (Phase 4).
4. Implement categories/payment methods.
5. Implement repositories.
6. Add core transaction UI.
7. Implement credit cards (liability computed, per `.github/skills/credit-card-logic-review`).
8. Implement sync.

## Known issues
- Android debug build stalled during first-time Gradle setup at `assembleDebug`.
- `flutter analyze` passed with no issues on 2026-09-08.
- `flutter test` passed with 1 test on 2026-09-08.

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
