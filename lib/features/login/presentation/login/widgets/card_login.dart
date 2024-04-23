import 'dart:async';

import 'package:challenge_disruptive/common/user_preferences.dart';
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
      child: Form(
        key: formkey,
        child: Column(
          children: [
            CustomTextFormField(
              label: "Email",
              controller: tecEmail,
              hintText: "prueba@gmail.com",
              inputValueType: InputValueType.email,
              onChanged: (x) => pageState.firstValidation!
                  ? formkey.currentState!.validate()
                  : null,
            ),
            CustomTextFormField(
              label: "Password",
              hintText: "******************",
              controller: tecPassword,
              inputValueType: InputValueType.password,
              onChanged: (x) => pageState.firstValidation!
                  ? formkey.currentState!.validate()
                  : null,
            ),
            const SizedBox(height: 10),
            PrimaryButton(
              text: "Iniciar sesión",
              isLoading: pageState.isLoading,
              onPressed: () async => await login(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> login(BuildContext context) async {
    pageController.setFirtsValidation(true);
    if (formkey.currentState!.validate()) {
      pageController.setIsLoading(true);

      Future.delayed(const Duration(seconds: 2), () {
        bool? goToHome = false;
        for (var element in pageState.users!) {
          if (element.user == tecEmail.text &&
              element.password == tecPassword.text) {
            goToHome = true;
            prefs.loggedIn = true;
            pageController.setIsLoading(false);
            pageController.setFirtsValidation(false);
            context.go(Routes.home);
          }
        }
        pageController.setIsLoading(false);
        !goToHome!
            ? dialogs.showMessageDialog(context,
                data: ModalDinamicData(
                    title: "Error",
                    subtitle:
                        "Las credenciales son incorrectas. Si no tienes una cuenta, regístrate."))
            : null;
      });
    }
  }
}
