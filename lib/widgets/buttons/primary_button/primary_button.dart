import 'package:app_restaurant/tools/custom_colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary }

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final ButtonType buttonType;
  final Widget? icon;
  final bool enabled;
  final double? height;
  final double? width;
  final bool? isLoading;
  final double? fontSizeText;
  final EdgeInsetsGeometry? buttonPadding;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    required this.buttonType,
    this.icon,
    required this.enabled,
    this.height,
    this.width,
    this.isLoading,
    this.fontSizeText,
    this.buttonPadding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled && isLoading == false ? () => onPressed() : null,
      child: Container(
        height: height ?? 20,
        width: width ?? 100,
        decoration: BoxDecoration(),
      ),
    );
  }

  _getBackgroundColor(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.primary:
        return textColor ??
            (enabled
                ? colors.primaryButtonColor
                : colors.primaryButtonDisabledColor);

      case ButtonType.secondary:
        return backgroundColor ??  
            (enabled
                ? colors.secundaryButtonColor
                : colors.secundaryButtonDisabledColor);

      default:
        return backgroundColor ??
            (enabled
                ? colors.primaryButtonColor
                : colors.primaryButtonDisabledColor);
    }
  }

  _getBorderColor(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.primary:
        return borderColor ??
            (enabled
                ? colors.primaryButtonColor
                : colors.primaryButtonDisabledColor);

      case ButtonType.secondary:
        return borderColor ??
            (enabled ? colors.textColor : colors.primaryButtonDisabledColor);

      default:
        return backgroundColor ??
            (enabled
                ? colors.primaryButtonColor
                : colors.primaryButtonDisabledColor);
    }
  }

  _getTextColor(ButtonType buttonType) {
    switch (buttonType) {
      case ButtonType.primary:
        return textColor ?? Colors.white;

      case ButtonType.secondary:
        return textColor ?? colors.textColor;

      default:
        return backgroundColor ??
            (enabled
                ? colors.primaryButtonColor
                : colors.primaryButtonDisabledColor);
    }
  }
}

// class PrimaryButton extends StatelessWidget {
//   const PrimaryButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor,
//     this.buttonType = ButtonType.primary,
//     this.icon,
//     this.enabled = true,
//     this.height,
//     this.width,
//     this.textColor,
//     this.borderColor,
//     this.isLoading = false,
//     this.fontSizeText,
//     this.buttonPadding,
//   });

//   final String text;
//   final Function onPressed;
//   final Color? backgroundColor;
//   final Color? textColor;
//   final Color? borderColor;
//   final ButtonType buttonType;
//   final Widget? icon;
//   final bool enabled;
//   final double? height;
//   final double? width;
//   final bool? isLoading;
//   final double? fontSizeText;
//   final EdgeInsetsGeometry? buttonPadding;

//   @override
//   Widget build(BuildContext context) {
//     return TextButtonTheme(
//       data: TextButtonThemeData(
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(
//                 _getBackgroundColor(buttonType),
//               ),
//               maximumSize: width != null
//                   ? MaterialStatePropertyAll(Size(width!, 100))
//                   : null,
//               shape: MaterialStateProperty.all(
//                 RoundedRectangleBorder(
//                   side: BorderSide(
//                       color: borderColor ?? _getBorderColor(buttonType)),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               minimumSize:
//                   MaterialStateProperty.all(Size(width ?? 160, height ?? 52)),

//               /// Color icon
//               foregroundColor:
//                   MaterialStateProperty.all(_getBackgroundColor(buttonType)),
//               overlayColor: MaterialStateProperty.all(Colors.transparent))),
//       child: TextButton(
//           onPressed: enabled && isLoading == false ? () => onPressed() : null,
//           child: Padding(
//             padding:
//                 buttonPadding ?? const EdgeInsets.symmetric(horizontal: 10),
//             child: Row(
//               mainAxisAlignment: icon != null
//                   ? MainAxisAlignment.spaceEvenly
//                   : MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 if (isLoading!) ...[
//                   SizedBox(
//                     height: 40,
//                     width: 40,
//                     child: Image.asset(gifs.loading),
//                   )
//                 ] else ...[
//                   CustomText(
//                     text,
//                     textColor: textColor ?? _getTextColor(buttonType),
//                     fontWeight: FontWeight.w500,
//                     fontSize: fontSizeText ?? 20,
//                   ),
//                 ]
//               ],
//             ),
//           )),
//     );
//   }


// }


