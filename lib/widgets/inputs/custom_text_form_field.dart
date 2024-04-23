import 'package:challenge_disruptive/tools/custom_colors.dart';
import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/paths/paths_icons.dart';
import 'package:challenge_disruptive/tools/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFormField extends StatefulWidget {
  /// Titulo input.
  final String label;
  final double? labelFontSize;
  final FontWeight? fontWeight;

  /// Text controller.
  final TextEditingController? controller;

  /// Whether the form is able to receive user input.
  final bool? enabled;

  /// Tipo de dato que se ingresará en el formulario.
  final InputValueType? inputValueType;

  /// Si es repetición de valor se debe validar.
  final String? matchValue;

  /// HintText del textFormField.
  final String? hintText;

  /// Ubicación icono de suffix;
  final String? suffixIconPath;

  /// Ubicación icono de prefix;
  final String? prefixIconPath;
  //Funcion para detectar los cambios en los inputs
  final Function(String)? onChanged;
  // Boleano para detectar errores del back que afecten el input
  final bool? errorBack;

  final String? timeToCompare;

  final Color? backgroundColor;

  final bool? suffixIconEnabled;

  final double? titleSpacingHeigth;
  final double? preffixSpacingWidth;

  final double? runSpacing;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.suffixIconPath,
    this.controller,
    this.enabled = true,
    this.inputValueType = InputValueType.text,
    this.matchValue,
    this.hintText,
    this.onChanged,
    this.errorBack = false,
    this.timeToCompare,
    this.prefixIconPath,
    this.labelFontSize,
    this.fontWeight,
    this.backgroundColor,
    this.suffixIconEnabled = true,
    this.titleSpacingHeigth,
    this.runSpacing,
    this.preffixSpacingWidth,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode focusNode = FocusNode();
  bool obscureText = false;
  bool? showError = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });

    Future.delayed(
      Duration.zero,
      () => {
        _defineObscureTextValue(),
        _addTextControllerListener(),
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != "") ...[
          Row(
            children: [
              CustomText(
                widget.label,
                fontWeight: widget.fontWeight ?? FontWeight.w400,
                fontSize: widget.labelFontSize ?? 16,
                textColor: Colors.white,
              ),
            ],
          ),
          SizedBox(height: widget.titleSpacingHeigth ?? 5),
        ],
        Container(
          height: 48,
          padding: const EdgeInsets.only(left: 16, right: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.fromBorderSide(BorderSide(color: _accentColor())),
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: widget.controller,
            validator: (x) => _validateInput(x ?? ''),
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            textInputAction: TextInputAction.none,
            style: const TextStyle(
              fontFamily: "Roboto",
              color: Colors.white,
              fontSize: 16,
            ),
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isCollapsed: true,
                errorStyle: const TextStyle(
                  fontSize: 0,
                  color: Colors.red,
                ),
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "Roboto",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: widget.suffixIconEnabled! ? currentIcon() : null,
                prefixIcon: widget.prefixIconPath != null
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: widget.preffixSpacingWidth ?? 6),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            widget.prefixIconPath!,
                            colorFilter: ColorFilter.mode(
                                focusNode.hasFocus ? Colors.white : Colors.grey,
                                BlendMode.srcIn),
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : null,
                prefixIconConstraints:
                    const BoxConstraints(maxHeight: 25, maxWidth: 25)),
            keyboardType: _keyboardType(),
            inputFormatters: [
              if (widget.inputValueType == InputValueType.password ||
                  widget.inputValueType == InputValueType.changePasword ||
                  widget.inputValueType == InputValueType.email) ...[
                FilteringTextInputFormatter.deny(
                    RegExp(r'\s')), // Rechazar espacios en blanco
              ],
              if (widget.inputValueType == InputValueType.phone) ...[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(8),
              ],
              if (widget.inputValueType == InputValueType.document ||
                  widget.inputValueType == InputValueType.number) ...[
                FilteringTextInputFormatter.digitsOnly
              ],
              if (widget.inputValueType == InputValueType.document) ...[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                LengthLimitingTextInputFormatter(13),
              ],
              if (widget.inputValueType == InputValueType.name) ...[
                FilteringTextInputFormatter.deny(
                    RegExp(r'\s')), // Rechazar espacios en blanco
                FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),
              ],
            ],
            obscureText: obscureText,
            obscuringCharacter: "*",
            cursorHeight: 24,
            cursorWidth: 1,
            cursorColor: Colors.white,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              /// Mensaje error
              if (showError! && errorMessage != "") ...[
                const SizedBox(height: 11),
                Row(
                  children: [
                    SvgPicture.asset(
                      icons.warning,
                      height: 20,
                      colorFilter:
                          const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: context.width(.8),
                      child: CustomText(
                        errorMessage ?? "Esto es un error",
                        textColor: colors.errorColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.runSpacing ?? 27),
              ] else ...[
                if (!widget.errorBack!) ...[
                  SizedBox(
                    height: widget.runSpacing ?? 27,
                  )
                ] else ...[
                  const SizedBox(
                    height: 5,
                  )
                ]
              ]
            ],
          ),
        )
      ],
    );
  }

  void onTapSuffixIcon() {
    obscureText = !obscureText;
    setState(() {});
  }

  Color _accentColor() {
    if (showError! || widget.errorBack!) {
      return colors.errorColor;
    }
    return focusNode.hasFocus ? Colors.white : Colors.grey;
  }

  _defineObscureTextValue() {
    setState(() {
      obscureText = (widget.inputValueType == InputValueType.password);
    });
  }

  _validate(String text) {
    switch (widget.inputValueType) {
      case InputValueType.email:
        errorMessage = validateEmail(text);
        break;
      case InputValueType.password:
        errorMessage = validatePassword(text,
            matchValue: widget.matchValue, errorBack: widget.errorBack);
        break;
      case InputValueType.changePasword:
        errorMessage =
            validateChangePassword(text, matchValue: widget.matchValue);
        break;

      case InputValueType.phone:
        errorMessage = validatePhone(text, matchValue: widget.matchValue);
        break;
      case InputValueType.document:
        errorMessage = validateDocument(text);
        break;
      case InputValueType.number:
        errorMessage = validateNumber(text);
        break;
      case InputValueType.currency:
      case InputValueType.text:
      default:
        errorMessage = validateText(text, matchValue: widget.matchValue);
        break;
    }
    showError = errorMessage != null;
    return errorMessage;
  }

  _addTextControllerListener() {
    if (widget.controller != null) {
      widget.controller!.addListener(() {});
    }
  }

  currentIcon() {
    switch (widget.inputValueType) {
      case InputValueType.password:
      case InputValueType.changePasword:
        return InkWell(
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          onTap: () => onTapSuffixIcon(),
          child: Container(
            height: 24,
            width: 24,
            alignment: Alignment.center,
            child: Stack(
              children: [
                SvgPicture.asset(
                  obscureText ? icons.closedEyePassword : icons.openEyePassword,
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ],
            ),
          ),
        );

      case InputValueType.email:
      case InputValueType.phone:
      case InputValueType.document:
      default:
        return Container(width: 0);
    }
  }

  String? _validateInput(String x) {
    _validate(x);
    setState(() {});
    return errorMessage;
  }

  _keyboardType() {
    switch (widget.inputValueType) {
      case InputValueType.email:
        return TextInputType.emailAddress;

      ///
      case InputValueType.password:
      case InputValueType.changePasword:
        return TextInputType.visiblePassword;

      ///
      case InputValueType.phone:
      case InputValueType.number:
      case InputValueType.document:
        return TextInputType.number;

      ///
      case InputValueType.text:
      case InputValueType.name:
      default:
        return TextInputType.text;
    }
  }
}

enum InputValueType {
  text,
  number,
  phone,
  email,
  password,
  changePasword,
  document,
  currency,
  name,
}
