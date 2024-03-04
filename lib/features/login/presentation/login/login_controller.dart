import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'login_state.dart';


class LoginController extends StateNotifier<LoginState> {

  LoginController() : super(LoginState());


  void getIdScreen(int idScreen) {

    state = state.copyWith(idScreen: idScreen);

  }

}


final loginController =

    StateNotifierProvider<LoginController, LoginState>((ref) {

  return LoginController();

});

