import 'package:app_restaurant/widgets/buttons/buttons_login/buttons_login_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonsLoginController extends StateNotifier<ButtonsLoginState> {
  ButtonsLoginController() : super(ButtonsLoginState());

  void toggleSelection(int id) {
    state = state.copyWith(id: id);
  }
}

final buttonsLoginController = StateNotifierProvider.autoDispose<
    ButtonsLoginController, ButtonsLoginState>((ref) {
  return ButtonsLoginController();
});
