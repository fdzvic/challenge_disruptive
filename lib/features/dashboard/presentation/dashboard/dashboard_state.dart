import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/widgets/pages/home_screen.dart';

class DashboardState {
  final int? selectedIndexScreen;
  final String? titleCrypto;
  final String? priceCryto;
  final List<TradeData>? dataSource;
  DashboardState({
    this.selectedIndexScreen = 0,
    this.titleCrypto,
    this.priceCryto,
    this.dataSource,
  });

  DashboardState copyWith({
    int? selectedIndexScreen,
    String? titleCrypto,
    String? priceCryto,
    List<TradeData>? dataSource,
  }) {
    return DashboardState(
      selectedIndexScreen: selectedIndexScreen ?? this.selectedIndexScreen,
      titleCrypto: titleCrypto ?? this.titleCrypto,
      priceCryto: priceCryto ?? this.priceCryto,
      dataSource: dataSource ?? this.dataSource,
    );
  }
}
