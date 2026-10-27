import 'dart:io';

import 'package:drift/drift.dart';

import '../../domain/security/database_key_manager.dart';
import '../../infrastructure/database/encrypted_database_factory.dart';

part 'app_database.g.dart';

/// The root Drift database foundation for the application.
///
/// In Phase 3 Slice 1, this provides the encrypted database connection foundation
/// without entity tables.
@DriftDatabase(tables: [])
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
}
