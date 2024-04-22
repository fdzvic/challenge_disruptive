class LoginState {
  final int? idScreen;
  final bool? isLoading;

  LoginState({
    this.idScreen = 1,
    this.isLoading = false,
  });

  LoginState copyWith({
    int? idScreen,
    bool? isLoading,
  }) {
    return LoginState(
      idScreen: idScreen ?? this.idScreen,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
