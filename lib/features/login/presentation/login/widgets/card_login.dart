import 'package:challenge_disruptive/features/login/presentation/login/login_controller.dart';
import 'package:challenge_disruptive/features/login/presentation/login/login_state.dart';
import 'package:challenge_disruptive/tools/custom_dialogs.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/models/modal_dinamic_data.dart';
import 'package:challenge_disruptive/tools/routes.dart';
import 'package:challenge_disruptive/widgets/buttons/primary_button/primary_button.dart';
import 'package:challenge_disruptive/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CardLogin extends StatelessWidget {
  final TextEditingController tecEmail;
  final TextEditingController tecPassword;
  final GlobalKey<FormState> formkey;
  final LoginController pageController;
  final LoginState pageState;

  const CardLogin({
    super.key,
    required this.tecEmail,
    required this.tecPassword,
    required this.formkey,
    required this.pageController,
    required this.pageState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: Column(
        children: [
          CustomTextFormField(
            label: "Email",
            controller: tecEmail,
            inputValueType: InputValueType.email,
          ),
          CustomTextFormField(
            label: "Password",
            controller: tecPassword,
            inputValueType: InputValueType.password,
          ),
          const SizedBox(height: 10),
          PrimaryButton(
            text: "Iniciar sesión",
            isLoading: pageState.isLoading,
            onPressed: () async => await login(context),
          ),
        ],
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    try {
      pageController.setIsLoading(true);
      await pageController.loginRepository
          .signInWithEmailAndPassword(tecEmail.text, tecPassword.text);
      if (!context.mounted) return;
      pageController.setIsLoading(false);
      context.go(Routes.home);
    } catch (e) {
      pageController.setIsLoading(false);

      dialogs.showMessageDialog(context,
          data: ModalDinamicData(
              title: 'Error al iniciar sesión',
              subtitle: e.toString(),
              labelButton: 'Ok'));
    }
  }
}
