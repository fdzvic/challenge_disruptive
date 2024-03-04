import 'package:app_restaurant/tools/dimens_extension.dart';
import 'package:app_restaurant/widgets/inputs/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CardLogin extends StatelessWidget {
  final TextEditingController tecEmail;
  final TextEditingController tecPassword;
  final GlobalKey<FormState> formkey;

  const CardLogin({
    super.key,
    required this.tecEmail,
    required this.tecPassword,
    required this.formkey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height(.4),
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
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
