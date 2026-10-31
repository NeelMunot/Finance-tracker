import 'package:drift/drift.dart';

import '../converters/converters.dart';

/// Common persistence and synchronization metadata mixin for all syncable entities (ADR-014).
mixin SyncableTable on Table {
  /// UTC epoch milliseconds when the entity was created locally.
  IntColumn get createdAt => integer()();

  /// UTC epoch milliseconds when the entity was last modified locally.
  IntColumn get updatedAt => integer()();

  /// Soft-delete tombstone (UTC epoch ms). Null if active/archived; timestamp if deleted.
  IntColumn get deletedAt => integer().nullable()();

  /// Synchronization state with Cloud Firestore ('pending', 'synced', 'conflict').
  TextColumn get syncStatus => text()
      .map(const SyncStatusConverter())
      .withDefault(const Constant('pending'))();

  /// Local mutation counter incremented on every write.
  IntColumn get version => integer().withDefault(const Constant(1))();
}
