import 'package:flutter/material.dart';
import 'package:repo_viewer/splash/presentation/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Repo Viewer',
      home: SplashPage(),
    );
  }
}
