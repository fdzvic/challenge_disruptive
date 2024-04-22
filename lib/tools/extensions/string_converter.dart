extension StringConverter on String {
  String toCurrency() {
    try {
      dynamic x = this;
      x ??= 0;

      if (x.runtimeType == String) {
        x = num.parse(x ?? '0').round();
      }
      List<String> parts = x.toString().split(',');
      RegExp re = RegExp(r'\B(?=(\d{3})+(?!\d))');

      parts.first = parts.first.replaceAll(re, ',');

      return "L ${parts.first}";
    } catch (e) {
      return this;
    }
  }

  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  num toNumber() {
    return num.tryParse(replaceAll("\$", "").replaceAll(",", "")) ?? 0;
  }

  /// String
  capitalize() {
    if (trim().isNotEmpty) {
      /// Se pasa todo el texto a minusculas y convierte en una lista de strings
      List<String> capitalizedText = toLowerCase().split('');

      /// pattern de caracteres, con estos se valida que letra se volverá mayúscula
      RegExp regex = RegExp(r'^[!¿¡?.;]');

      for (var i = 0; i < capitalizedText.length; i++) {
        /// La posición 0 siempre irá en mayuscula
        capitalizedText.first = capitalizedText.first.toUpperCase();

        /// Se pregunta por empieza por la posicion 2 porque se validarán
        ///  las 2 posiciones casillas del texto
        if (i > 1) {
          /// Si la posición anterion es un caracter, la actual se volverá mayuscula
          if (regex.hasMatch(this[(i - 1)])) {
            capitalizedText[i] = capitalizedText[i].toUpperCase();

            /// si la anterior es un espacio se validará la posicion anterior a esta
          } else if (this[(i - 1)] == ' ') {
            if (regex.hasMatch(this[(i - 2)])) {
              capitalizedText[i] = capitalizedText[i].toUpperCase();
            }
          }
        }
      }

      /// se vuelve el array de string un string
      return capitalizedText.join('');
    }
    return '--';
  }

  String toPhone() {
    try {
      String x = this;
      return "${x.substring(0, 3)} ${x.substring(3, 6)} ${x.substring(6, 10)}";
    } catch (e) {
      return this;
    }
  }
}
