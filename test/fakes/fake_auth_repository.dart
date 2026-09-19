import 'dart:async';

import 'package:finance_tracker/domain/auth/auth_repository.dart';
import 'package:finance_tracker/domain/auth/auth_user.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository([this._initialUser])
    : _controller = StreamController<AuthUser?>.broadcast(sync: true);

  final AuthUser? _initialUser;
  final StreamController<AuthUser?> _controller;
  AuthUser? nextSignInUser;
  Object? signInError;
  Object? signOutError;

  @override
  Stream<AuthUser?> get authStateChanges async* {
    yield _initialUser;
    yield* _controller.stream;
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    final error = signInError;
    if (error != null) {
      throw error;
    }
    return nextSignInUser ??
        const AuthUser(id: 'fake-user', email: 'fake@example.com');
  }

  @override
  Future<void> signOut() async {
    final error = signOutError;
    if (error != null) {
      throw error;
    }
    _controller.add(null);
  }

  void emit(AuthUser? user) => _controller.add(user);

  Future<void> dispose() => _controller.close();
}
