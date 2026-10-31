import 'dart:io';

import 'package:drift/drift.dart';

import '../../domain/security/database_key_manager.dart';
import '../../infrastructure/database/encrypted_database_factory.dart';
import 'tables/tables.dart';

export 'tables/tables.dart';

part 'app_database.g.dart';

/// The root Drift database for the application.
///
/// Encrypted via SQLCipher and scoped to the authenticated user (ADR-011, ADR-013).
/// Foreign keys are explicitly enforced on open.
@DriftDatabase(
  tables: [Categories, CreditCards, PaymentMethods, Transactions, Attachments],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Factory constructor to create an authenticated user-scoped encrypted database.
  factory AppDatabase.forUser({
    required String userId,
    required DatabaseKeyManager keyManager,
    Future<Directory> Function()? getDirectory,
    bool inBackground = true,
  }) {
    final executor = EncryptedDatabaseFactory.createLazyEncryptedDatabase(
      userId: userId,
      keyManager: keyManager,
      getDirectory: getDirectory,
      inBackground: inBackground,
    );
    return AppDatabase(executor);
  }

  /// Factory constructor for testing with custom query executors.
  factory AppDatabase.forTesting(QueryExecutor executor) {
    return AppDatabase(executor);
  }

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON;');
    },
  );
}
