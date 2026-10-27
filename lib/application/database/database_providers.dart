import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/database/app_database.dart';
import '../../domain/security/database_key_manager.dart';
import '../../infrastructure/security/secure_storage_database_key_manager.dart';
import '../auth/auth_providers.dart';

/// Provides the active [DatabaseKeyManager] implementation.
final databaseKeyManagerProvider = Provider<DatabaseKeyManager>((ref) {
  return SecureStorageDatabaseKeyManager();
});

/// Scoped provider for the authenticated user's encrypted [AppDatabase].
///
/// Automatically disposes and closes the database connection on sign-out or scope teardown.
/// Never deletes database files or encryption keys automatically on sign-out.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final userScope = ref.watch(requiredUserScopeProvider);
  final keyManager = ref.watch(databaseKeyManagerProvider);

  final database = AppDatabase.forUser(
    userId: userScope.userId,
    keyManager: keyManager,
  );

  ref.onDispose(() {
    database.close();
  });

  return database;
});
