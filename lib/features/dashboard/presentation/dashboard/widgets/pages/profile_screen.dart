import 'package:challenge_disruptive/common/user_preferences.dart';
import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/routes.dart';
import 'package:challenge_disruptive/widgets/buttons/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: context.horizontal(.05),
        height: context.height(.87),
        width: context.width(),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText('Profile Screen'),
            const SizedBox(height: 50),
            PrimaryButton(
              text: 'Cerrar sesión',
              onPressed: () {
                prefs.loggedIn = false;
                context.go(Routes.login);
              },
            ),
          ],
        )));
  }
}
