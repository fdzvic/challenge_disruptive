import 'package:challenge_disruptive/features/login/domain/users.dart';

class LoginState {
  final int? idScreen;
  final bool? isLoading;
  final bool? firstValidation;
  final Users? usersData;

  LoginState({
    this.idScreen = 1,
    this.isLoading = false,
    this.firstValidation = false,
    this.usersData,
  });

  LoginState copyWith({
    int? idScreen,
    bool? isLoading,
    bool? firstValidation,
    Users? usersData,
  }) {
    return LoginState(
      idScreen: idScreen ?? this.idScreen,
      isLoading: isLoading ?? this.isLoading,
      firstValidation: firstValidation ?? this.firstValidation,
      usersData: usersData ?? this.usersData,
    );
  }
}
