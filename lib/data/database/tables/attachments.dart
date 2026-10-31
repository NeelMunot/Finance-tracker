import 'package:drift/drift.dart';

import '../converters/converters.dart';
import 'syncable_table.dart';
import 'transactions.dart';

/// Receipt and document metadata associated with transactions.
@DataClassName('Attachment')
class Attachments extends Table with SyncableTable {
  /// Unique client-generated UUIDv4 identifier.
  TextColumn get id => text()();

  /// Foreign key referencing Transactions.id. Physical deletion cascades; soft-deletion is domain-handled.
  TextColumn get transactionId =>
      text().references(Transactions, #id, onDelete: KeyAction.cascade)();

  /// Cloud Storage path.
  TextColumn get storagePath => text()();

  /// Original file name.
  TextColumn get fileName => text()();

  /// MIME type (e.g. 'image/jpeg', 'application/pdf').
  TextColumn get mimeType => text()();

  /// File size in bytes.
  IntColumn get sizeBytes => integer()();

  /// AI receipt extraction status ('NOT_PROCESSED', 'PENDING', 'DONE', 'FAILED').
  TextColumn get aiProcessingStatus =>
      text().map(const AiProcessingStatusConverter()).nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
