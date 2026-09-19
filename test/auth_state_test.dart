import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finance_tracker/application/auth/auth_providers.dart';
import 'package:finance_tracker/domain/auth/auth_state.dart';
import 'package:finance_tracker/domain/auth/auth_user.dart';

import 'fakes/fake_auth_repository.dart';

void main() {
  test(
    'maps signed-out and signed-in repository events to auth state',
    () async {
      final repository = FakeAuthRepository();
      final container = ProviderContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(() async {
        container.dispose();
        await repository.dispose();
      });

      expect(container.read(authStateProvider), isA<AuthLoading>());
      await Future<void>.delayed(Duration.zero);
      expect(container.read(authStateProvider), isA<AuthSignedOut>());

      const user = AuthUser(id: 'user-1', email: 'user@example.com');
      repository.emit(user);
      expect(container.read(authStateProvider), isA<AuthSignedIn>());
      expect(container.read(userScopeProvider)?.userId, 'user-1');
    },
  );

  test(
    'exposes authentication errors and guards unauthenticated scope',
    () async {
      final repository = FakeAuthRepository()
        ..signInError = StateError('failed');
      final container = ProviderContainer(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(() async {
        container.dispose();
        await repository.dispose();
      });

      await Future<void>.delayed(Duration.zero);
      await container.read(authStateProvider.notifier).signInWithGoogle();

      expect(container.read(authStateProvider), isA<AuthError>());
      expect(
        () => container.read(requiredUserScopeProvider),
        throwsA(isA<Exception>()),
      );
    },
  );
}
