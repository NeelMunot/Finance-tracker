import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth/auth_state.dart';
import '../../domain/auth/user_scope.dart';
import 'auth_state_notifier.dart';

export 'auth_repository_provider.dart';

final authStateProvider = NotifierProvider<AuthStateNotifier, AuthState>(
  AuthStateNotifier.new,
);

final userScopeProvider = Provider<UserScope?>((ref) {
  final authState = ref.watch(authStateProvider);
  return switch (authState) {
    AuthSignedIn(:final user) => UserScope(user.id),
    _ => null,
  };
});

final requiredUserScopeProvider = Provider<UserScope>((ref) {
  final scope = ref.watch(userScopeProvider);
  if (scope == null) {
    throw const UnauthenticatedUserException();
  }
  return scope;
});
