import 'package:challenge_disruptive/features/login/data/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_state.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController({required this.loginRepository}) : super(LoginState());

  final LoginRepository loginRepository;

  void getIdScreen(int idScreen) {
    state = state.copyWith(idScreen: idScreen);
  }

  void setIsLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }
}

final loginController =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(loginRepository: ref.watch(loginRepositoryProvider));
});
