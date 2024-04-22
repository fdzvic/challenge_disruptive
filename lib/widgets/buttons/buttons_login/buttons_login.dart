import 'package:challenge_disruptive/tools/custom_colors.dart';
import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/widgets/buttons/buttons_login/buttons_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef Callback = void Function(int? response);

class ButtonsLogin extends ConsumerStatefulWidget {
  final Callback callback;
  final int id;
  final String label;

  const ButtonsLogin({
    super.key,
    required this.callback,
    required this.id,
    required this.label,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ButtonsLoginState();
}

class _ButtonsLoginState extends ConsumerState<ButtonsLogin> {
  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(buttonsLoginController.notifier);
    var state = ref.watch(buttonsLoginController);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => {
            controller.toggleSelection(widget.id),
            widget.callback(widget.id)
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(
                          color: widget.id == state.id
                              ? colors.blueDark
                              : Colors.transparent))),
              child: CustomText(widget.label,
                  fontSize: 20,
                  textColor:
                      widget.id == state.id ? colors.blueDark : Colors.white)),
        ),
      ],
    );
  }
}
