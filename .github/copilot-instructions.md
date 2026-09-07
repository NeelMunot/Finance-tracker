# Copilot Instructions — Personal Finance & Investment Tracker

## Role
You are working on a personal finance and investment tracking mobile application built with Flutter, for personal use (single user, primarily Android).

Treat the repository as the source of truth. Before making changes, inspect the relevant existing code and the project documentation under `docs/`. Path-specific rules live in `.github/instructions/` and are applied automatically based on the files you're editing — read them too when they apply.

## Core stack
- Flutter / Dart
- Riverpod for application state
- Drift + SQLite (SQLCipher-encrypted) for local structured data
- Firebase Authentication with Google Sign-In
- Firebase App Check (configured from Phase 2, not deferred)
- Cloud Firestore for cloud persistence/synchronization
- Firebase Storage for receipt/attachment files
- Firebase AI Logic / Gemini for AI features
- `fl_chart` or another justified Flutter charting library
- `flutter_local_notifications` where notifications are implemented
- CSV/XLSX export

Do not replace a core technology without documenting the reason in `docs/decisions.md`.

## v1 scope — read this before touching money-related code
- **There is no bank account / balance-tracking entity.** `PaymentMethod` is a label only. Do not add balance fields, an `Account` entity, or reconciliation logic. See `docs/decisions.md` ADR-008.
- Credit-card liability is **computed at query time** from transactions, never stored as a balance column.
- Amounts are integer minor units, never floating point (ADR-009).
- IDs are client-generated UUIDs; timestamps are UTC epoch milliseconds (ADR-010).

## Non-negotiable architecture rules
1. Flutter UI must not contain business logic.
2. UI must not directly access Drift tables, Firestore, or Firebase Storage.
3. All financial mutations must pass through the domain/application business-logic layer.
4. Keep local persistence behind repository/data-access abstractions.
5. Drift/SQLite (encrypted) is the operational local database.
6. Firestore is the cloud synchronization/persistence layer, not the application's only database.
7. Core transaction entry must work offline.
8. AI must never have unrestricted database access.
9. AI output is untrusted input and must pass schema and domain validation.
10. Receipt AI processing is optional; a receipt can be stored without it.
11. AI-generated transaction drafts must be editable and normally user-confirmed before final persistence.
12. Credit-card spending is calculated using the card's billing cycle, not the calendar month.
13. Credit-card bill payments must not double-count the underlying expense.
14. Financial calculations must have unit tests.
15. Database schema changes require proper Drift migrations.
16. Avoid logging sensitive financial information.
17. Never hard-code API keys, access tokens, Firebase secrets, or other credentials.
18. Do not add a dependency merely for convenience; justify new dependencies.
19. Do not silently change architecture decisions. Record meaningful changes in `docs/decisions.md`.
20. Do not introduce an Account/balance entity without a new ADR (see "v1 scope" above).

## Project context files
Before planning a non-trivial change, read as appropriate:
- `docs/requirements.md`
- `docs/architecture.md`
- `docs/data-model.md`
- `docs/development-state.md`
- `docs/decisions.md`
- `docs/roadmap.md`

When a change affects one of these areas, update the corresponding documentation.

## Development workflow
For a non-trivial task:
1. Inspect the current implementation.
2. Read the relevant project documentation and applicable `.github/instructions/*.instructions.md` files.
3. Identify affected modules and dependencies.
4. Check current library/platform documentation (Context7 MCP) before using APIs that may have changed.
5. Produce a concise implementation plan before editing. Wait for approval on anything larger than a small task.
6. Implement incrementally.
7. Run relevant formatting, static analysis, and tests.
8. Review for architectural violations.
9. Update project state/documentation when the project state changes.

## Definition of done
A feature is not done merely because the code compiles. For a meaningful feature, verify:
- architecture is respected (including "v1 scope" above)
- tests exist for business-critical logic
- formatting/static analysis passes
- relevant tests pass
- offline behavior is preserved where applicable
- sync and security impact are considered
- documentation/state is updated when necessary

## Repository memory discipline
After completing a meaningful feature, update `docs/development-state.md`.
After making an architectural decision, add/update an entry in `docs/decisions.md`.
Keep `docs/roadmap.md` aligned with completed and upcoming work.
These files preserve project context across future AI-agent sessions — do not rely on chat history alone.
