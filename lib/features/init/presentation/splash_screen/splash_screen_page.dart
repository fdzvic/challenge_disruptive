import 'dart:async';
import 'dart:convert';
import 'package:challenge_disruptive/common/user_preferences.dart';
import 'package:challenge_disruptive/features/login/domain/mock_users.dart';
import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/tools/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:is_first_run/is_first_run.dart';

class SplashScreenPage extends ConsumerStatefulWidget {
  const SplashScreenPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatedController;
  late bool isFirstRun;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      isFirstRun = await IsFirstRun.isFirstRun();
    });

    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    Timer(const Duration(seconds: 5), () {
      isFirstRun ? prefs.usersRegistered = json.encode(mockUsers) : null;
      prefs.loggedIn ? context.go(Routes.home) : context.go(Routes.login);
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var controller = ref.watch(splashScreenController.notifier);
    // var state = ref.watch(splashScreenController);

    return Scaffold(
      body: SafeArea(
          child: Center(
              child: AnimatedBuilder(
        animation: _animatedController,
        builder: (context, child) {
          return AnimatedOpacity(
              opacity: _animatedController.value < 0.5 ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 500),
              child: const CustomText(
                "Cargando...",
                textColor: Colors.black,
              ));
        },
      ))),
    );
  }
}
