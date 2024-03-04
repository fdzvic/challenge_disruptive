import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_state.dart';

class HomeController extends StateNotifier<HomeState> {
 
  HomeController(): super(HomeState());
}

final homeController =
    StateNotifierProvider<HomeController, HomeState>(
        (ref) {
  return HomeController();
});