# Development State

Last updated: 2026-09-08

## Current phase
Repository / AI-context bootstrap — foundational decisions now locked in (Phase 0.5 complete).

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

## In progress
- Initialize Flutter project.
- Configure repository.
- Configure Firebase development environment.

## Next
1. Create Flutter application foundation (Phase 1).
2. Configure authentication + Firebase App Check together (Phase 2).
3. Implement Drift schema (encrypted) per `docs/data-model.md` v1 (Phase 3).
4. Implement transaction domain / use cases (Phase 4).
5. Implement categories/payment methods.
6. Implement repositories.
7. Add core transaction UI.
8. Implement credit cards (liability computed, per `.github/skills/credit-card-logic-review`).
9. Implement sync.

## Known issues
- None recorded.

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
