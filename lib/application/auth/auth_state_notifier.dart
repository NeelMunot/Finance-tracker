import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth/auth_repository.dart';
import '../../domain/auth/auth_state.dart';
import 'auth_repository_provider.dart';

class AuthStateNotifier extends Notifier<AuthState> {
  StreamSubscription<dynamic>? _authSubscription;
  late AuthRepository _repository;

  @override
  AuthState build() {
    _repository = ref.watch(authRepositoryProvider);
    state = const AuthLoading();
    _authSubscription = _repository.authStateChanges.listen(
      (user) {
        state = user == null ? const AuthSignedOut() : AuthSignedIn(user);
      },
      onError: (Object error, StackTrace stackTrace) {
        state = AuthError(error, stackTrace);
      },
    );
    ref.onDispose(() => _authSubscription?.cancel());
    return const AuthLoading();
  }

  Future<void> signInWithGoogle() async {
    state = const AuthLoading();
    try {
      final user = await _repository.signInWithGoogle();
      state = AuthSignedIn(user);
    } catch (error, stackTrace) {
      state = AuthError(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    state = const AuthLoading();
    try {
      await _repository.signOut();
      state = const AuthSignedOut();
    } catch (error, stackTrace) {
      state = AuthError(error, stackTrace);
    }
  }
}
