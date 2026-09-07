---
name: add-domain-usecase
description: Use when adding a new use case/operation to the transaction engine (e.g. a new way to create, edit, search, or summarize transactions). Ensures it converges on the shared engine instead of creating a parallel write path.
---

# Add a Domain Use Case

Follow this sequence whenever a new capability needs to read or mutate transactions,
categories, payment methods, or credit cards.

1. Read `docs/architecture.md` ("Transaction Engine") and `docs/data-model.md` first.
2. Check whether an existing use case in `lib/domain/` or `lib/application/` already
   covers this — do not create a second path to persistence for something that
   already exists (e.g. don't write a bespoke Firestore write for AI-originated
   transactions when a manual-entry use case already exists).
3. Define the use case as a small, pure, testable class/function taking a validated
   input and a repository interface — no Flutter imports, no direct Drift/Firestore
   calls.
4. Add domain validation (not just type/schema validation) appropriate to the
   operation: required fields, business rules (e.g. category must be active,
   credit-card payment method must resolve to a real card).
5. Wire it into the appropriate repository interface; implement the repository method
   in the data layer per `.github/instructions/data-layer.instructions.md`.
6. Add unit tests covering: the happy path, at least one validation failure, and any
   credit-card/billing-cycle interaction if relevant.
7. Update `docs/development-state.md` with a one-line dated note.
8. If this introduces a new AI-facing capability, list it explicitly (e.g.
   `search_transactions`) rather than exposing the underlying repository.
