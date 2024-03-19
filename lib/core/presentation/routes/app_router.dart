import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:repo_viewer/auth/presentation/authorization_page.dart';
import 'package:repo_viewer/auth/presentation/sign_in_page.dart';
import 'package:repo_viewer/splash/presentation/splash_page.dart';
import 'package:repo_viewer/starred_repos/presentation/starred_repos_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
        ),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: AuthorizationRoute.page),
        AutoRoute(page: StarredReposRoute.page),
      ];
}
