import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/security/database_key_manager.dart';

/// Concrete implementation of [DatabaseKeyManager] utilizing [FlutterSecureStorage]
/// with Android Keystore namespace isolation.
class SecureStorageDatabaseKeyManager implements DatabaseKeyManager {
  SecureStorageDatabaseKeyManager({FlutterSecureStorage? storage})
    : _storage =
          storage ??
          const FlutterSecureStorage(
            aOptions: AndroidOptions(storageNamespace: 'finance_tracker_vault'),
          );

  final FlutterSecureStorage _storage;

  static final RegExp _hexKeyRegex = RegExp(r'^[0-9a-fA-F]{64}$');

  static const String _keyPrefix = 'db_key_';

  @override
  String sanitizeUserId(String userId) {
    if (userId.trim().isEmpty) {
      throw const DatabaseKeyException('User identifier cannot be empty.');
    }
    return userId.toSanitizedUserHash();
  }

  String _storageKeyForUser(String userId) {
    final sanitized = sanitizeUserId(userId);
    return '$_keyPrefix$sanitized';
  }

  @override
  Future<String> getOrCreateKey(String userId) async {
    final storageKey = _storageKeyForUser(userId);

    String? existingKey;
    try {
      existingKey = await _storage.read(key: storageKey);
    } on Object catch (_) {
      // Never expose platform or storage details that might leak secrets
      throw const DatabaseKeyException(
        'Failed to read database encryption key from secure storage.',
      );
    }

    if (existingKey != null && existingKey.isNotEmpty) {
      if (!_hexKeyRegex.hasMatch(existingKey)) {
        throw const DatabaseKeyException(
          'Stored database encryption key is corrupted or has an invalid format.',
        );
      }
      return existingKey;
    }

    // Generate a fresh 256-bit cryptographically secure key
    final newKey = _generateSecureRandomKey();

    try {
      await _storage.write(key: storageKey, value: newKey);
    } on Object catch (_) {
      throw const DatabaseKeyException(
        'Failed to persist database encryption key to secure storage.',
      );
    }

    return newKey;
  }

  @override
  Future<void> deleteKey(String userId) async {
    final storageKey = _storageKeyForUser(userId);
    try {
      await _storage.delete(key: storageKey);
    } on Object catch (_) {
      throw const DatabaseKeyException(
        'Failed to delete database encryption key from secure storage.',
      );
    }
  }

  /// Generates a 256-bit (32 bytes) cryptographically secure random key
  /// encoded as a 64-character lowercase hexadecimal string.
  static String _generateSecureRandomKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}
