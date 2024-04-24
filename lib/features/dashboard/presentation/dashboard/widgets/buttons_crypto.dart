import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:flutter/material.dart';

class ButtonsCrypto extends StatelessWidget {
  const ButtonsCrypto({
    super.key,
    required this.label,
    this.icon,
    required this.price,
    this.onTap,
  });

  final String label;
  final String? icon;
  final String price;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 5),
        width: context.width(),
        color: Colors.white.withOpacity(.1),
        child: Row(
          children: [
            SizedBox(
              height: context.height(.05),
              width: context.width(.1),
              child: icon != null
                  ? Image.asset(
                      icon!,
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            const SizedBox(width: 15),
            CustomText(label),
            const Expanded(child: SizedBox(width: 10)),
            CustomText(price)
          ],
        ),
      ),
    );
  }
}
