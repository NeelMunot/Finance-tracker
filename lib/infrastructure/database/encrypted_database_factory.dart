import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../domain/security/database_key_manager.dart';

/// Thrown when database encryption verification or security constraints fail.
///
/// Contains no sensitive key material in its message or stack trace.
class DatabaseSecurityException implements Exception {
  const DatabaseSecurityException(this.message);

  final String message;

  @override
  String toString() => 'DatabaseSecurityException: $message';
}

/// Factory responsible for configuring and opening SQLCipher-encrypted
/// SQLite database connections for authenticated user scopes.
class EncryptedDatabaseFactory {
  const EncryptedDatabaseFactory._();

  static final RegExp _hexKeyRegex = RegExp(r'^[0-9a-fA-F]{64}$');

  /// Verifies that SQLCipher is compiled into and active in the underlying SQLite library.
  ///
  /// Throws [DatabaseSecurityException] if SQLCipher is absent or returns an empty version.
  static void verifySqlCipherAvailable(Database rawDb) {
    final result = rawDb.select('PRAGMA cipher_version;');
    if (result.isEmpty ||
        result.first.values.isEmpty ||
        result.first.values.first == null ||
        result.first.values.first.toString().trim().isEmpty) {
      throw const DatabaseSecurityException(
        'SQLCipher is not active in the SQLite binary. Plaintext SQLite fallback is strictly prohibited.',
      );
    }
  }

  /// Applies the 256-bit encryption key to [rawDb] and validates decryption.
  ///
  /// Checks format, sets foreign keys to ON, executes `PRAGMA key`, and validates
  /// readability of the database schema. If key derivation or decryption fails,
  /// throws [DatabaseSecurityException] and closes/fails closed immediately.
  static void applyAndVerifyEncryptionKey(
    Database rawDb,
    String encryptionKey,
  ) {
    if (!_hexKeyRegex.hasMatch(encryptionKey)) {
      throw const DatabaseSecurityException(
        'Invalid database encryption key format. 256-bit hexadecimal key required.',
      );
    }

    // 1. Verify SQLCipher cipher availability before applying key
    verifySqlCipherAvailable(rawDb);

    // 2. Apply raw hex 256-bit key via SQLCipher raw hex literal syntax
    rawDb.execute("PRAGMA key = \"x'$encryptionKey'\";");

    // 3. Enforce relational integrity
    rawDb.execute('PRAGMA foreign_keys = ON;');

    // 4. Force SQLCipher key derivation and header decryption by reading sqlite_master.
    // If the key is wrong, or if the file was created with another key / corrupted,
    // SQLCipher throws SqliteException (code 26: file is not a database).
    try {
      rawDb.select('SELECT count(*) FROM sqlite_master;');
    } on Object catch (_) {
      throw const DatabaseSecurityException(
        'Failed to unlock encrypted database. Decryption key may be invalid or database file is corrupted.',
      );
    }
  }

  /// Resolves the user-isolated database file path: `app_user_<hash>.db`.
  static Future<File> getDatabaseFileForUser({
    required String userId,
    required DatabaseKeyManager keyManager,
    Future<Directory> Function()? getDirectory,
  }) async {
    final dir = getDirectory != null
        ? await getDirectory()
        : await getApplicationDocumentsDirectory();

    final sanitizedHash = keyManager.sanitizeUserId(userId);
    final filename = 'app_user_$sanitizedHash.db';
    return File(p.join(dir.path, filename));
  }

  /// Creates a Drift [QueryExecutor] pointing to [file] secured with [encryptionKey].
  static QueryExecutor createEncryptedExecutor({
    required File file,
    required String encryptionKey,
    bool inBackground = true,
  }) {
    if (inBackground) {
      return NativeDatabase.createInBackground(
        file,
        setup: (rawDb) => applyAndVerifyEncryptionKey(rawDb, encryptionKey),
      );
    } else {
      return NativeDatabase(
        file,
        setup: (rawDb) => applyAndVerifyEncryptionKey(rawDb, encryptionKey),
      );
    }
  }

  /// Creates a [LazyDatabase] resolving the user's encryption key and file on first access.
  static LazyDatabase createLazyEncryptedDatabase({
    required String userId,
    required DatabaseKeyManager keyManager,
    Future<Directory> Function()? getDirectory,
    bool inBackground = true,
  }) {
    return LazyDatabase(() async {
      final key = await keyManager.getOrCreateKey(userId);
      final file = await getDatabaseFileForUser(
        userId: userId,
        keyManager: keyManager,
        getDirectory: getDirectory,
      );
      return createEncryptedExecutor(
        file: file,
        encryptionKey: key,
        inBackground: inBackground,
      );
    });
  }
}
