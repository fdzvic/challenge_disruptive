import 'package:challenge_disruptive/features/login/presentation/login/login_controller.dart';
import 'package:challenge_disruptive/features/login/presentation/login/login_state.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/widgets/buttons/primary_button/primary_button.dart';
import 'package:challenge_disruptive/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CardRegister extends StatelessWidget {
  const CardRegister({
    super.key,
    required this.tecEmail,
    required this.tecPassword,
    required this.formkey,
    required this.pageController,
    required this.pageState,
  });

  final TextEditingController tecEmail;
  final TextEditingController tecPassword;
  final GlobalKey<FormState> formkey;
  final LoginController pageController;
  final LoginState pageState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: Column(
        children: [
          CustomTextFormField(
            label: "Correo electrónico",
            controller: tecEmail,
            inputValueType: InputValueType.email,
          ),
          CustomTextFormField(
            label: "Contraseña",
            controller: tecPassword,
            inputValueType: InputValueType.password,
          ),
          CustomTextFormField(
            label: "Confirmar contraseña",
            controller: tecPassword,
            inputValueType: InputValueType.password,
          ),
          const SizedBox(height: 10),
          PrimaryButton(
            text: "Registrarse",
            isLoading: pageState.isLoading,
            onPressed: () async {},
          ),
        ],
      ),
    );
  }
}
