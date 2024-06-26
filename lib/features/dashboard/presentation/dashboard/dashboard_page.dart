import 'dart:convert';

import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/dashboard_controller.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/dashboard_state.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/widgets/custom_bottom_navigator_bar.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/widgets/pages/home_screen.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/widgets/pages/profile_screen.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/widgets/pages/search_screen.dart';
import 'package:challenge_disruptive/features/login/presentation/login/widgets/background_login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<DashboardPage> {
  final List<TradeData> btcData = [];
  final List<TradeData> ethData = [];
  final List<TradeData> adaData = [];
  final channelBTC = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/btcusdt@trade');
  final channelETH = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/ethusdt@trade');
  final channelADA = IOWebSocketChannel.connect(
      'wss://stream.binance.com:9443/ws/adausdt@trade');

  @override
  void initState() {
    super.initState();
    streamListenerBTC();
    streamListenerETH();
    streamListenerADA();
  }

  void streamListenerBTC() {
    channelBTC.stream.listen((message) {
      Map<String, dynamic> getData = jsonDecode(message);
      if (mounted) {
        setState(() {
          btcData.add(TradeData(DateTime.now(), double.parse(getData['p'])));
        });
      }
    });
  }

  void streamListenerETH() {
    channelETH.stream.listen((message) {
      Map<String, dynamic> getData = jsonDecode(message);
      if (mounted) {
        setState(() {
          ethData.add(TradeData(DateTime.now(), double.parse(getData['p'])));
        });
      }
    });
  }

  void streamListenerADA() {
    channelADA.stream.listen((message) {
      Map<String, dynamic> getData = jsonDecode(message);
      if (mounted) {
        setState(() {
          adaData.add(TradeData(DateTime.now(), double.parse(getData['p'])));
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    channelBTC.sink.close();
    channelETH.sink.close();
    channelADA.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(dashboardController.notifier);
    var state = ref.watch(dashboardController);
    return BackgrounLogin(
        viewBottomNavigationBar: true,
        bottomNavigationBar: CustomBottomNavigationBar(
          pageController: controller,
          pageState: state,
        ),
        child: Column(
          children: [getScreen(controller: controller, state: state)],
        ));
  }

  Widget getScreen(
      {required DashboardController controller,
      required DashboardState state}) {
    switch (state.selectedIndexScreen) {
      case 0:
        return HomeScreen(
          controller: controller,
          state: state,
          btcData: btcData,
          ethData: ethData,
          adaData: adaData,
        );
      case 1:
        return SearchScreen(context: context);
      case 2:
        return ProfileScreen(context: context);

      default:
        return Container();
    }
  }
}
