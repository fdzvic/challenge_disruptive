import 'package:challenge_disruptive/tools/models/modal_dinamic_data.dart';
import 'package:challenge_disruptive/widgets/modals/modal_message.dart';
import 'package:flutter/material.dart';

///
/// Esta clase contiene todos los mensajes de dialogo que se mostrarán dentro de la aplicación
///

class CustomDialogs {
  showMessageDialog(
    BuildContext context, {
    required ModalDinamicData data,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(.8),
      builder: (BuildContext context) {
        return ModalMessage(data: data);
      },
    );
  }
}

final CustomDialogs dialogs = CustomDialogs();
