import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'splash_screen_state.dart';

class SplashScreenController extends StateNotifier<SplashScreenState> {
 
  SplashScreenController(): super(SplashScreenState());
}

final splashScreenController =
    StateNotifierProvider<SplashScreenController, SplashScreenState>(
        (ref) {
  return SplashScreenController();
});