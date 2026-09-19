import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth/auth_providers.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finance Tracker')),
      body: Center(
        child: FilledButton.icon(
          onPressed: () =>
              ref.read(authStateProvider.notifier).signInWithGoogle(),
          icon: const Icon(Icons.login),
          label: const Text('Sign in with Google'),
        ),
      ),
    );
  }
}
