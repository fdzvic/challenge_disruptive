import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal() {
    initPrefs();
  }

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GET y SET de token
  String get jwt {
    return _prefs.getString('jwt') ?? '';
  }

  set jwt(String value) {
    _prefs.setString('jwt', value);
  }

  // GET y SET de datos del usuario
  String get userData {
    return _prefs.getString('userData') ?? '';
  }

  set userData(String value) {
    _prefs.setString('userData', value);
  }
}

final UserPreferences prefs = UserPreferences();
