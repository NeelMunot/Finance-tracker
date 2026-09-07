---
name: add-drift-migration
description: Use whenever a Drift table needs a new column, new table, or type change. Ensures schema changes follow proper versioned migrations and stay aligned with docs/data-model.md.
---

# Add a Drift Migration

1. Update `docs/data-model.md` first — the doc describes the intended schema; the
   Drift table definition should follow it, not the other way around.
2. Bump the Drift schema version and write an explicit migration step (`onUpgrade`),
   never edit a previously-shipped migration step in place.
3. Preserve existing data: default values or backfill logic for new non-nullable
   columns, not a destructive table rebuild, unless the table has never shipped to a
   real database.
4. If the change affects a field also synced to Firestore, note the Firestore-side
   implication in `docs/decisions.md` (e.g. do old and new app versions read the same
   document shape safely during rollout?).
5. Add/update a migration test that runs the upgrade path from the previous schema
   version and asserts the resulting shape and any backfilled data.
6. Confirm the change doesn't reintroduce anything ruled out by ADR-008 (no
   account/balance table) or ADR-009/ADR-010 (money as integer minor units, IDs as
   UUID strings, timestamps as epoch ms).
7. Record the change in `docs/changelog.md`.
