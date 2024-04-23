import 'package:challenge_disruptive/features/login/domain/users.dart';
import 'package:challenge_disruptive/features/login/presentation/login/login_controller.dart';
import 'package:challenge_disruptive/features/login/presentation/login/login_state.dart';
import 'package:challenge_disruptive/tools/custom_dialogs.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/models/modal_dinamic_data.dart';
import 'package:challenge_disruptive/widgets/buttons/buttons_login/buttons_login_controller.dart';
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
    required this.tecConfirmPassword,
    required this.buttonsController,
  });

  final TextEditingController tecEmail;
  final TextEditingController tecPassword;
  final TextEditingController tecConfirmPassword;
  final GlobalKey<FormState> formkey;
  final LoginController pageController;
  final LoginState pageState;
  final ButtonsLoginController buttonsController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      child: Form(
        key: formkey,
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
              controller: tecConfirmPassword,
              matchValue: tecPassword.text,
              inputValueType: InputValueType.changePasword,
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              text: "Registrarse",
              isLoading: pageState.isLoading,
              onPressed: () => verifyNewUser(context),
            ),
          ],
        ),
      ),
    );
  }

  void verifyNewUser(BuildContext context) {
    bool validUser = true;
    for (var element in pageState.users!) {
      if (element.user == tecEmail.text) {
        validUser = false;
        dialogs.showMessageDialog(context,
            data: ModalDinamicData(
                title: "Error",
                subtitle: "Ya existe un usuario con este correo",
                onPressed: () {
                  Navigator.pop(context);
                }));
      }
    }
    validUser ? register(context) : null;
  }

  void register(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      pageController.setIsLoading(true);
      await Future.delayed(const Duration(seconds: 3));
      pageController
          .addNewUser(User(user: tecEmail.text, password: tecPassword.text));
      pageController.setIsLoading(false);
      if (!context.mounted) return;
      dialogs.showMessageDialog(context,
          data: ModalDinamicData(
              title: "Felicitaciones",
              subtitle: "Usuario agregado con éxito",
              onPressed: () {
                pageController.getIdScreen(1);
                buttonsController.toggleSelection(1);
                clearTec();
                Navigator.pop(context);
              }));
    }
  }

  clearTec() {
    tecEmail.clear();
    tecPassword.clear();
    tecConfirmPassword.clear();
  }
}
