import 'package:challenge_disruptive/features/login/domain/users.dart';

class LoginState {
  final int? idScreen;
  final bool? isLoading;
  final bool? firstValidation;
  final List<User>? users;
  final String? matchValuePassword;

  LoginState({
    this.idScreen = 1,
    this.isLoading = false,
    this.firstValidation = false,
    this.users,
    this.matchValuePassword,
  });

  LoginState copyWith({
    int? idScreen,
    bool? isLoading,
    bool? firstValidation,
    List<User>? users,
    String? matchValuePassword,
  }) {
    return LoginState(
      idScreen: idScreen ?? this.idScreen,
      isLoading: isLoading ?? this.isLoading,
      firstValidation: firstValidation ?? this.firstValidation,
      users: users ?? this.users,
      matchValuePassword: matchValuePassword ?? this.matchValuePassword,
    );
  }
}
