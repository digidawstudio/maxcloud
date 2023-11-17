import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomDoubleLineChart {
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
      String title, List<DoubleChartData>? chartData) {
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
          labelFormat: '{value}${labelDenom(title)}',
          axisLine: const AxisLine(width: 1),
          majorTickLines: const MajorTickLines(width: 1),
          majorGridLines: const MajorGridLines(width: 0)),
      series: _getDefaultLineSeries(chartData),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  static List<ChartSeries<DoubleChartData, DateTime>> _getDefaultLineSeries(
      List<DoubleChartData>? chartData) {
    final List<Color> color = <Color>[];
    color.add(const Color(0x59d8f3ff));
    color.add(const Color(0xff45a7f5));

    final List<double> stops = <double>[];
    stops.add(0.0);
    stops.add(1.0);

    final List<Color> color2 = <Color>[];
    color2.add(const Color(0xffe6e6ff));
    color2.add(const Color(0xff6666ff));

    final List<double> stops2 = <double>[];
    stops2.add(0.0);
    stops2.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
        colors: color,
        stops: stops,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    final LinearGradient gradientColors2 = LinearGradient(
        colors: color2,
        stops: stops2,
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    return <ChartSeries<DoubleChartData, DateTime>>[
      StackedAreaSeries<DoubleChartData, DateTime>(
          borderColor: const Color(0xff4d4dff),
          borderWidth: 1.2,
          gradient: gradientColors2,
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (DoubleChartData sales, _) => sales.x,
          yValueMapper: (DoubleChartData sales, _) => sales.y2,
          // width: 2,
          markerSettings: const MarkerSettings(
            isVisible: true,
            borderWidth: 0,
            width: 0,
            height: 0,
            color: Color(0xff4d4dff),
          )),
      StackedAreaSeries<DoubleChartData, DateTime>(
          borderColor: const Color(0xFF009EFF),
          borderWidth: 1.2,
          gradient: gradientColors,
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (DoubleChartData sales, _) => sales.x,
          yValueMapper: (DoubleChartData sales, _) => sales.y,
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

class DoubleChartData {
  DoubleChartData(this.x, this.y, this.y2);
  final DateTime x;
  final double y;
  final double y2;
}
