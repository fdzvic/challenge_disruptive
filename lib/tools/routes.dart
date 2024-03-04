import 'package:app_restaurant/features/dashboard/presentation/home/home_page.dart';
import 'package:app_restaurant/features/init/presentation/splash_screen/splash_screen_page.dart';
import 'package:app_restaurant/features/login/presentation/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String rootRoute = '/splash-screen';
  static const String login = '/login';
  static const String home = '/home';
}

final router = GoRouter(initialLocation: Routes.rootRoute, routes: [
  GoRoute(
      path: Routes.rootRoute,
      pageBuilder: (context, state) =>
          page(state: state, child: const SplashScreenPage())),
  GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) =>
          page(state: state, child: const LoginPage())),
  GoRoute(
      path: Routes.home,
      pageBuilder: (context, state) =>
          page(state: state, child: const HomePage())),
]);

NoTransitionPage<void> page(
        {required GoRouterState state, required Widget child}) =>
    NoTransitionPage<void>(key: state.pageKey, child: child);
