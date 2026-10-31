import 'package:drift/drift.dart';

import '../converters/converters.dart';
import 'syncable_table.dart';

/// Categories table for income and expense taxonomy.
@DataClassName('Category')
class Categories extends Table with SyncableTable {
  /// Unique client-generated UUIDv4 identifier.
  TextColumn get id => text()();

  /// User-defined category name.
  TextColumn get name => text()();

  /// Category type ('INCOME' or 'EXPENSE').
  TextColumn get type => text().map(const CategoryTypeConverter())();

  /// Optional Material icon identifier.
  TextColumn get icon => text().nullable()();

  /// Optional hex color string (e.g. '#RRGGBB').
  TextColumn get color => text().nullable()();

  /// User-facing archive toggle. Archiving hides from pickers while preserving historical transactions.
  BoolColumn get active => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
