import 'package:flutter/material.dart';
import 'package:repo_viewer/core/presentation/routes/app_router.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final AppRouter _appRouter;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Repo Viewer',
      routerConfig: _appRouter.config(),
    );
  }

  @override
  void initState() {
    _appRouter = AppRouter();
    super.initState();
  }
}
