class LoginState {

  final int? idScreen;


  LoginState({

    this.idScreen = 1,

  });


  LoginState copyWith({

    int? idScreen,

  }) {

    return LoginState(idScreen: idScreen ?? this.idScreen);

  }

}

