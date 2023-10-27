import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomLineChart {
  static String labelDenom(String title) {
    String denom = '';
    if (title.toLowerCase().contains('cpu')) {
      denom = '%';
    }
    if (title.toLowerCase().contains('memory')) {
      denom = 'mb';
    }
    if (title.toLowerCase().contains('network')) {
      denom = 'b';
    }
    if (title.toLowerCase().contains('disk')) {
      denom = 'b';
    }
    return denom;
  }

  static SfCartesianChart buildDefaultLineChart(
      String title, List<ChartData>? chartData) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(
          alignment: ChartAlignment.near,
          text: title,
          textStyle: GoogleFonts.manrope(
              textStyle: const TextStyle(
                  color: Color(0xff353333),
                  fontSize: 14,
                  fontWeight: FontWeight.w600))),
      primaryXAxis: DateTimeAxis(
          labelFormat: '{value}',
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          axisLine: const AxisLine(width: 1),
          interval: 2,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}' + labelDenom(title),
          axisLine: const AxisLine(width: 1),
          majorTickLines: const MajorTickLines(width: 1),
          majorGridLines: const MajorGridLines(width: 0)),
      series: _getDefaultLineSeries(chartData),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static List<ChartSeries<ChartData, DateTime>> _getDefaultLineSeries(
      List<ChartData>? chartData) {
    final List<Color> color = <Color>[];
    color.add(Color(0x59d8f3ff));
    color.add(Color(0xff45a7f5));

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
        colors: color,
        stops: stops,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    return <ChartSeries<ChartData, DateTime>>[
      AreaSeries<ChartData, DateTime>(
          borderColor: Color(0xFF009EFF),
          borderWidth: 1.2,
          gradient: gradientColors,
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (ChartData sales, _) => sales.x,
          yValueMapper: (ChartData sales, _) => sales.y,
          // width: 2,
          markerSettings: const MarkerSettings(
            isVisible: true,
            borderWidth: 0,
            width: 0,
            height: 0,
            color: Color(0xFF009EFF),
          )),
    ];
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final DateTime x;
  final double y;
}
