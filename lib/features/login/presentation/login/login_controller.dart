import 'dart:convert';
import 'package:challenge_disruptive/common/user_preferences.dart';
import 'package:challenge_disruptive/features/login/data/login_repository.dart';
import 'package:challenge_disruptive/features/login/domain/users.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController({required this.loginRepository}) : super(LoginState());

  final LoginRepository loginRepository;
  late Users usersData;

  Future<void> initData() async {
    usersData = Users.fromJson(json.decode(prefs.usersRegistered));
    state = state.copyWith(users: usersData.users);
  }

  void addNewUser(User newUser) {
    late Users users;
    List<User>? newUsers = state.users;
    newUsers!.add(newUser);
    state = state.copyWith(users: newUsers);
    users = Users(users: newUsers);
    prefs.usersRegistered = json.encode(users.toJson());
  }

  void getIdScreen(int idScreen) {
    state = state.copyWith(idScreen: idScreen, firstValidation: false);
  }

  void setIsLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setFirtsValidation(bool value) {
    state = state.copyWith(firstValidation: value);
  }

  void setMatchValuePassword(String password) {
    state = state.copyWith(matchValuePassword: password);
  }
}

final loginController =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(loginRepository: ref.watch(loginRepositoryProvider));
});
