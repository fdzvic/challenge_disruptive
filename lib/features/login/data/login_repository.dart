import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginRepository {}

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepository(),
);
