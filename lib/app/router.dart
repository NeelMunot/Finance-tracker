import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/auth/auth_providers.dart';
import '../domain/auth/auth_state.dart';
import '../presentation/auth/auth_error_screen.dart';
import '../presentation/auth/auth_loading_screen.dart';
import '../presentation/auth/sign_in_screen.dart';
import '../presentation/home/home_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/loading',
        builder: (context, state) => const AuthLoadingScreen(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/auth-error',
        builder: (context, state) => AuthErrorScreen(
          error: authState is AuthError
              ? authState
              : AuthError(StateError('Unknown authentication error.')),
        ),
      ),
    ],
    redirect: (context, state) {
      final target = switch (authState) {
        AuthLoading() => '/loading',
        AuthSignedOut() => '/sign-in',
        AuthSignedIn() => '/',
        AuthError() => '/auth-error',
      };
      return state.matchedLocation == target ? null : target;
    },
  );
});
