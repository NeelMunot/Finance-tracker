import 'dart:math';

import 'package:finance_tracker/domain/security/database_key_manager.dart';

/// In-memory fake implementation of [DatabaseKeyManager] for testing.
class FakeDatabaseKeyManager implements DatabaseKeyManager {
  final Map<String, String> _keys = {};

  static final RegExp _hexKeyRegex = RegExp(r'^[0-9a-fA-F]{64}$');

  @override
  String sanitizeUserId(String userId) {
    if (userId.trim().isEmpty) {
      throw const DatabaseKeyException('User identifier cannot be empty.');
    }
    return userId.toSanitizedUserHash();
  }

  @override
  Future<String> getOrCreateKey(String userId) async {
    final storageKey = sanitizeUserId(userId);
    final existing = _keys[storageKey];

    if (existing != null) {
      if (!_hexKeyRegex.hasMatch(existing)) {
        throw const DatabaseKeyException(
          'Stored database encryption key is corrupted or has an invalid format.',
        );
      }
      return existing;
    }

    final newKey = _generateSecureRandomKey();
    _keys[storageKey] = newKey;
    return newKey;
  }

  @override
  Future<void> deleteKey(String userId) async {
    final storageKey = sanitizeUserId(userId);
    _keys.remove(storageKey);
  }

  bool hasKey(String userId) {
    return _keys.containsKey(sanitizeUserId(userId));
  }

  void seedCorruptKey(String userId, String corruptValue) {
    _keys[sanitizeUserId(userId)] = corruptValue;
  }

  void seedKey(String userId, String validKey) {
    _keys[sanitizeUserId(userId)] = validKey;
  }

  static String _generateSecureRandomKey() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}
