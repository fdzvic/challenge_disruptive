import 'package:challenge_disruptive/features/login/data/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
  HomeController({required this.loginRepository}) : super(HomeState());

  final LoginRepository loginRepository;
}

final homeController = StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController(loginRepository: ref.watch(loginRepositoryProvider));
});
