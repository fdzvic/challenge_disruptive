import 'package:app_restaurant/features/login/presentation/login/login_controller.dart';
import 'package:app_restaurant/features/login/presentation/login/widgets/background_login.dart';
import 'package:app_restaurant/features/login/presentation/login/widgets/card_login.dart';
import 'package:app_restaurant/features/login/presentation/login/widgets/card_register.dart';
import 'package:app_restaurant/tools/custom_colors.dart';
import 'package:app_restaurant/tools/custom_text.dart';
import 'package:app_restaurant/tools/dimens_extension.dart';
import 'package:app_restaurant/tools/styles.dart';
import 'package:app_restaurant/widgets/buttons/buttons_login/buttons_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginPage> {
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  GlobalKey<FormState> formkey =
      GlobalKey<FormState>(debugLabel: '_loginFormKey');

  
  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(loginController.notifier);
    var state = ref.watch(loginController);
    return BackgrounLogin(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: context.horizontal(.05),
            child: Column(
              children: [
                const CustomText(
                  'Iniciar Sesión',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 15),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: styles.textStyle(),
                    children: [
                      const TextSpan(
                          text: "Al iniciar sesión estás aceptando nuestros "),
                      TextSpan(
                          text: "términos y política de privacidad.",
                          style: styles.textStyle(textColor: colors.blueNormal))
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonsLogin(
                      id: 1,
                      label: "Iniciar sesion",
                      callback: (response) => controller.getIdScreen(response!),
                    ),
                    const SizedBox(width: 15),
                    ButtonsLogin(
                      label: "Registarse",
                      id: 2,
                      callback: (response) => controller.getIdScreen(response!),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                getScreen(state.idScreen!)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getScreen(int idScreen) {
    switch (idScreen) {
      case 1:
        return CardLogin(
          formkey: formkey,
          tecEmail: tecEmail,
          tecPassword: tecPassword,
        );
      case 2:
        return const CardRegister();

      default:
        return SizedBox(
          height: context.height(.3),
          width: context.width(),
        );
    }
  }
}
