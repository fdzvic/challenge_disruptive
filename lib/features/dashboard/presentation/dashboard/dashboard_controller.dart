import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/widgets/pages/home_screen.dart';
import 'package:challenge_disruptive/features/login/data/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dashboard_state.dart';

class DashboardController extends StateNotifier<DashboardState> {
  DashboardController({required this.loginRepository})
      : super(DashboardState());

  final LoginRepository loginRepository;

  void setSelectIndexScreen(int value) {
    state = state.copyWith(selectedIndexScreen: value);
  }

  void setGraphValues(
      {String? titleCrypto, String? priceCryto, List<TradeData>? dataSource}) {
    state = state.copyWith(
      titleCrypto: titleCrypto,
      priceCryto: priceCryto,
      dataSource: dataSource,
    );
  }
}

final dashboardController =
    StateNotifierProvider.autoDispose<DashboardController, DashboardState>(
        (ref) {
  return DashboardController(
      loginRepository: ref.watch(loginRepositoryProvider));
});
