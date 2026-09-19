import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/auth/auth_providers.dart';
import '../../domain/auth/auth_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final user = authState is AuthSignedIn ? authState.user : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
        actions: [
          IconButton(
            onPressed: () => ref.read(authStateProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: const Center(child: Text('Project foundation ready')),
      bottomNavigationBar: user == null
          ? null
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Signed in as ${user.email}'),
            ),
    );
  }
}
