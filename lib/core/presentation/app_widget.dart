import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repo_viewer/auth/shared/providers.dart';
import 'package:repo_viewer/core/presentation/routes/app_router.dart';
import 'package:repo_viewer/core/shared/providers.dart';

final initializationProvider = FutureProvider<void>(
  (ref) async {
    await ref.read(sembastProvider).init();
    final auth = ref.read(authNotifierProvider.notifier);
    await Future.delayed(Durations.extralong4);
    await auth.checkAndUpdateAuthenticationStatus();
  },
);

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..read(initializationProvider)
      ..watch(authNotifierProvider).mapOrNull(
        authenticated: (_) => _appRouter.pushAndPopUntil(
          const StarredReposRoute(),
          predicate: (route) => false,
        ),
        unauthenticated: (_) => _appRouter.pushAndPopUntil(
          const SignInRoute(),
          predicate: (route) => false,
        ),
      );

    return MaterialApp.router(
      title: 'Repo Viewer',
      routerConfig: _appRouter.config(),
    );
  }
}
