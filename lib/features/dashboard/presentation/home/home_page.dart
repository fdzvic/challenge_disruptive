import 'package:challenge_disruptive/features/dashboard/presentation/home/home_controller.dart';
import 'package:challenge_disruptive/tools/routes.dart';
import 'package:challenge_disruptive/widgets/buttons/primary_button/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(homeController.notifier);
    // var state = ref.watch(homeController);

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: PrimaryButton(
              text: 'Salir',
              onPressed: () {
                controller.loginRepository.signOut();
                context.go(Routes.login);
              },
            ),
          )
        ],
      )),
    );
  }
}
