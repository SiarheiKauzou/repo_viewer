import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/shared/providers.dart';

@RoutePage()
class StarredReposPage extends ConsumerWidget {
  const StarredReposPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: ref.read(authNotifierProvider.notifier).signOut,
          style: const ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            backgroundColor: MaterialStatePropertyAll(Colors.green),
          ),
          child: const Text('Sign Out'),
        ),
      ),
    );
  }
}
