import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth/auth_providers.dart';
import '../../domain/auth/auth_state.dart';

class AuthErrorScreen extends ConsumerWidget {
  const AuthErrorScreen({super.key, required this.error});

  final AuthError error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finance Tracker')),
      body: Center(
        child: FilledButton(
          onPressed: () =>
              ref.read(authStateProvider.notifier).signInWithGoogle(),
          child: const Text('Authentication failed. Try again.'),
        ),
      ),
    );
  }
}
