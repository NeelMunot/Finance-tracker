import 'package:drift/drift.dart';

import 'syncable_table.dart';

/// Credit card profiles for billing schedule and liability tracking (ADR-015).
///
/// Schema-only infrastructure in Phase 3; strictly prohibits payment credentials (PAN, CVV, PIN).
@DataClassName('CreditCard')
class CreditCards extends Table with SyncableTable {
  /// Unique client-generated UUIDv4 identifier.
  TextColumn get id => text()();

  /// User-defined card nickname (e.g. "Millennia", "Amazon Pay ICICI").
  TextColumn get name => text()();

  /// Card issuing bank or institution (e.g. "HDFC Bank", "ICICI").
  TextColumn get issuer => text()();

  /// Optional display label for distinguishing cards. When provided, must be exactly 4 numeric digits.
  TextColumn get lastFourDigits => text().nullable().customConstraint(
    "CHECK (last_four_digits IS NULL OR last_four_digits GLOB '[0-9][0-9][0-9][0-9]')",
  )();

  /// Optional credit limit in minor currency units (signed 64-bit int).
  IntColumn get creditLimitMinorUnits => integer().nullable().customConstraint(
    "CHECK (credit_limit_minor_units IS NULL OR credit_limit_minor_units >= 0)",
  )();

  /// Day of the month the statement is generated / cycle closes (1–31).
  IntColumn get statementDay => integer().customConstraint(
    "NOT NULL CHECK (statement_day BETWEEN 1 AND 31)",
  )();

  /// Day of the month payment is due (1–31).
  IntColumn get dueDay =>
      integer().customConstraint("NOT NULL CHECK (due_day BETWEEN 1 AND 31)")();

  /// User-facing archive toggle.
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
