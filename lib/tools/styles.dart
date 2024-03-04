import 'package:flutter/material.dart';

class CustomStyles {
  TextStyle textStyle({
    FontWeight? fontWeight,
    double? fontSize = 16,
    Color? textColor,
    TextDecoration? textDecoration,
    double? height,
    double? decorationThickness,
  }) =>
      TextStyle(
        fontFamily: 'Roboto',
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize!,
        color: textColor ?? Colors.black,
        decoration: textDecoration ?? TextDecoration.none,
        decorationColor: textColor ?? Colors.black,
        height: height,
        decorationThickness: decorationThickness,
      );
}

final CustomStyles styles = CustomStyles();
