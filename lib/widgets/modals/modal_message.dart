import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/models/modal_dinamic_data.dart';
import 'package:challenge_disruptive/widgets/buttons/primary_button/primary_button.dart';
import 'package:flutter/material.dart';

class ModalMessage extends StatelessWidget {
  const ModalMessage({
    super.key,
    required this.data,
  });

  final ModalDinamicData data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
          type: MaterialType.transparency,
          child: Container(
            width: data.widthContainer ?? context.width(.9),
            height: data.heightContainer,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data.title,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 10),
                CustomText(
                  data.subtitle,
                  fontSize: 16,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      text: data.labelButton ?? "OK",
                      width: context.width(.81),
                      onPressed: data.onPressed ?? () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
