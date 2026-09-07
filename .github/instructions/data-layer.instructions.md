---
applyTo: "lib/data/**,lib/infrastructure/**"
---

# Data / Persistence Layer Rules

- Drift is the only local persistence mechanism. Tables mirror `docs/data-model.md`
  exactly — field names, types (UUID strings, integer minor-unit amounts, epoch-ms
  timestamps), and the soft-delete (`deletedAt`) + sync (`updatedAt`, `syncStatus`,
  `version`) columns on every syncable table.
- The local database is opened via SQLCipher (encrypted). Never open or migrate to a
  plaintext connection, even for debugging — use the App Check debug provider /
  emulator suite instead of weakening local encryption.
- Any schema change is a proper Drift migration with a version bump, never an
  in-place edit to an existing migration step.
- Firestore documents mirror the same field conventions. Do not let a Firestore
  document shape diverge from the Drift schema without recording why in
  `docs/decisions.md`.
- Repositories are the only classes that touch Drift/Firestore/Storage directly.
  Application/domain code depends on repository interfaces, never on Drift generated
  classes or `FirebaseFirestore` directly.
- No `Account`/balance table. `payment_methods` is a plain label table (ADR-008).
