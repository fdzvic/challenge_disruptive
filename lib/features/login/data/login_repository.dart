import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  LoginRepository({required this.auth});

  final FirebaseAuth auth;
  Stream<User?> get authStateChange => auth.idTokenChanges();

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential response = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log(response.toString());

      return response.user;
    } on FirebaseAuthException catch (e) {
      log(e.code);
      log(e.toString());
      if (e.code == 'user-not-found') {
        throw 'Usuario no encontrado';
      } else if (e.code == 'invalid-email') {
        throw 'Correo invalido';
      } else if (e.code == 'invalid-credential') {
        throw 'Contraseña incorrecta';
      } else if (e.code == 'wrong-password') {
        throw 'Contraseña incorrecta';
      } else {
        throw 'Error inesperado, intentelo mas tarde';
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(auth: FirebaseAuth.instance),
);
