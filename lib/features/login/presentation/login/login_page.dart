import 'package:challenge_disruptive/features/login/presentation/login/login_controller.dart';
import 'package:challenge_disruptive/features/login/presentation/login/login_state.dart';
import 'package:challenge_disruptive/features/login/presentation/login/widgets/background_login.dart';
import 'package:challenge_disruptive/features/login/presentation/login/widgets/card_login.dart';
import 'package:challenge_disruptive/features/login/presentation/login/widgets/card_register.dart';
import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/widgets/buttons/buttons_login/buttons_login.dart';
import 'package:challenge_disruptive/widgets/buttons/buttons_login/buttons_login_controller.dart';
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
  TextEditingController tecConfirmPassword = TextEditingController();
  GlobalKey<FormState> formkeyLogin =
      GlobalKey<FormState>(debugLabel: '_loginFormKey');
  GlobalKey<FormState> formkeyRegister =
      GlobalKey<FormState>(debugLabel: '_registerFormKey');

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ref.watch(loginController.notifier).initData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(loginController.notifier);
    var buttonsController = ref.watch(buttonsLoginController.notifier);
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
                  'Bienvenido',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonsLogin(
                        id: 1,
                        label: "Iniciar sesion",
                        callback: (response) {
                          clearTec();
                          controller.getIdScreen(response!);
                        }),
                    const SizedBox(width: 15),
                    ButtonsLogin(
                        label: "Registarse",
                        id: 2,
                        callback: (response) {
                          clearTec();
                          controller.getIdScreen(response!);
                        }),
                  ],
                ),
                const SizedBox(height: 50),
                getScreen(
                    idScreen: state.idScreen!,
                    controller: controller,
                    state: state,
                    buttonsController: buttonsController)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getScreen(
      {required int idScreen,
      required LoginController controller,
      required ButtonsLoginController buttonsController,
      required LoginState state}) {
    switch (idScreen) {
      case 1:
        return CardLogin(
          pageController: controller,
          pageState: state,
          formkey: formkeyLogin,
          tecEmail: tecEmail,
          tecPassword: tecPassword,
        );
      case 2:
        return CardRegister(
          pageController: controller,
          pageState: state,
          formkey: formkeyRegister,
          tecEmail: tecEmail,
          tecPassword: tecPassword,
          tecConfirmPassword: tecConfirmPassword,
          buttonsController: buttonsController,
        );

      default:
        return SizedBox(
          height: context.height(.3),
          width: context.width(),
        );
    }
  }

  void clearTec() {
    tecEmail.clear();
    tecPassword.clear();
    tecConfirmPassword.clear();
  }
}
