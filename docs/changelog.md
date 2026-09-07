# Development Changelog

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
