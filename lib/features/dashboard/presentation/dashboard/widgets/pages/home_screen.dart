import 'dart:async';

import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/dashboard_controller.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/dashboard_state.dart';
import 'package:challenge_disruptive/features/dashboard/presentation/dashboard/widgets/buttons_crypto.dart';
import 'package:challenge_disruptive/tools/custom_text.dart';
import 'package:challenge_disruptive/tools/extensions/dimens_extension.dart';
import 'package:challenge_disruptive/tools/extensions/string_converter.dart';
import 'package:challenge_disruptive/tools/paths/paths_images.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key,
      required this.btcData,
      required this.ethData,
      required this.adaData,
      required this.controller,
      required this.state});
  final List<TradeData> btcData;
  final List<TradeData> ethData;
  final List<TradeData> adaData;
  final DashboardController controller;
  final DashboardState state;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  String? titleCrypto = "BTC/USDT Precio:";
  List<TradeData>? dataSource;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      widget.controller.setGraphValues(
          titleCrypto: "BTC/USDT Precio:",
          priceCryto: widget.btcData.isNotEmpty
              ? widget.btcData.last.price.toString().toCurrency()
              : "0",
          dataSource: widget.btcData);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    int count = 0;
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      widget.controller.setGraphValues(
          titleCrypto: titleCrypto,
          priceCryto: dataSource?.last.price.toString().toCurrency(),
          dataSource: dataSource);

      if (widget.btcData.isNotEmpty && count == 0) {
        count++;
        dataSource = widget.btcData;
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.horizontal(.05),
      width: context.width(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          CustomText(
            widget.state.titleCrypto,
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
            fontSize: 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              widget.state.priceCryto,
              fontWeight: FontWeight.bold,
              textColor: const Color.fromARGB(255, 250, 194, 25),
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: context.height(.4),
            width: context.width(.9),
            child: SfCartesianChart(
              primaryXAxis: const DateTimeAxis(
                majorGridLines: MajorGridLines(
                    width: 0), // Quitar las líneas de cuadrícula principales
                minorGridLines: MinorGridLines(width: 0),
              ),
              plotAreaBorderColor: Colors.transparent,
              primaryYAxis: const NumericAxis(
                majorGridLines: MajorGridLines(
                    width: 0), // Quitar las líneas de cuadrícula principales
                minorGridLines: MinorGridLines(width: 0),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <LineSeries<TradeData, DateTime>>[
                LineSeries<TradeData, DateTime>(
                  width: 1.5,
                  enableTooltip: true,
                  dataSource: widget.state.dataSource,
                  xValueMapper: (TradeData data, _) => data.time,
                  yValueMapper: (TradeData data, _) => data.price,
                ),
              ],
            ),
          ),
          ButtonsCrypto(
            label: "Bitcoin",
            price: widget.btcData.isNotEmpty
                ? widget.btcData.last.price.toString().toCurrency()
                : "0",
            icon: images.bitcionLogo,
            onTap: () {
              titleCrypto = "BTC/USDT Precio:";
              dataSource = widget.btcData;
            },
          ),
          ButtonsCrypto(
            label: "Ethereum",
            price: widget.ethData.isNotEmpty
                ? widget.ethData.last.price.toString().toCurrency()
                : "0",
            icon: images.ethereumLogo,
            onTap: () {
              titleCrypto = "ETH/USDT Precio:";
              dataSource = widget.ethData;
            },
          ),
          ButtonsCrypto(
            label: "Cardano",
            price: widget.adaData.isNotEmpty
                ? widget.adaData.last.price.toString().toCurrency()
                : "0",
            icon: images.cardanoLogo,
            onTap: () {
              titleCrypto = "ADA/USDT Precio:";
              dataSource = widget.adaData;
            },
          ),
        ],
      ),
    );
  }
}

class TradeData {
  final DateTime time;
  final double price;

  TradeData(this.time, this.price);
}
