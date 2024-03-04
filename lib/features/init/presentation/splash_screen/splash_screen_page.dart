import 'dart:async';

import 'package:app_restaurant/tools/custom_text.dart';
import 'package:app_restaurant/tools/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreenPage extends ConsumerStatefulWidget {
  const SplashScreenPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animatedController;

  @override
  void initState() {
    super.initState();

    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    Timer(const Duration(seconds: 5), () => context.go(Routes.login));
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
