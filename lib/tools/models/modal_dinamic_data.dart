import 'package:flutter/material.dart';

class ModalDinamicData {
  Widget? child;
  bool? dimisible;
  double? heightContainer;
  double? widthContainer;
  String? title;
  String? subtitle;
  String? labelButton;
  Function? onPressed;

  ModalDinamicData({
    this.child,
    this.dimisible,
    this.heightContainer,
    this.widthContainer,
    this.title,
    this.subtitle,
    this.labelButton,
    this.onPressed,
  });
}
