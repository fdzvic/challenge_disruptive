import 'package:flutter_flavor/flutter_flavor.dart';

///
/// Esta clase contiene todos los valores constantes en la aplicación
///

class Constants {
  String domain = FlavorConfig.instance.variables["baseUrl"];
}

final Constants constants = Constants();
