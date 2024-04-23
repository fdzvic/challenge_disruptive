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

  // GET y SET de primera compilacion del app
  bool get firstInitApp {
    return _prefs.getBool('firstInitApp') ?? false;
  }

  set firstInitApp(bool value) {
    _prefs.setBool('firstInitApp', value);
  }

  // GET y SET logueado
  bool get loggedIn {
    return _prefs.getBool('loggedIn') ?? false;
  }

  set loggedIn(bool value) {
    _prefs.setBool('loggedIn', value);
  }

  // GET y SET lista de usuarios registrados
  String get usersRegistered {
    return _prefs.getString('usersRegistered') ?? '';
  }

  set usersRegistered(String value) {
    _prefs.setString('usersRegistered', value);
  }
}

final UserPreferences prefs = UserPreferences();
