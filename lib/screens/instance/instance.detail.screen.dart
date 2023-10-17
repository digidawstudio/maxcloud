import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';
import 'package:maxcloud/screens/instance/components/line.chart.dart';
import 'package:maxcloud/utils/widgets.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class InstanceDetailScreen extends StatefulWidget {
  final InstanceData data;
  const InstanceDetailScreen({super.key, required this.data});

  @override
  State<InstanceDetailScreen> createState() => _InstanceDetailScreenState();
}

class _InstanceDetailScreenState extends State<InstanceDetailScreen> {
  List<ChartData>? chartData;

  @override
  void initState() {
    chartData = <ChartData>[
      ChartData(10.00, 4),
      ChartData(13.00, 1),
      ChartData(13.40, 8),
      ChartData(15.00, 9),
      ChartData(16.00, 7),
      ChartData(18.00, 10),
      ChartData(19.00, 6),
      ChartData(21.00, 9),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Detail",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
              height: 24, fit: BoxFit.scaleDown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/icons/windows.png",
                        height: 48,
                      ),
                      SizedBox(width: 12),
                      Text("didanalzabar91.",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff009EFF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                  Flexible(
                    flex: 3,
                    child: MaterialButton(
                      minWidth: 89.w,
                      height: 20.h,
                      elevation: 0,
                      color: Color(0xff02D430),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: () {},
                      child: Text(
                        "●  Running",
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/icons/monitor-icon.svg',
                          height: 28.h, fit: BoxFit.scaleDown),
                      SizedBox(width: 15.w),
                      SvgPicture.asset('assets/svg/icons/power-icon.svg',
                          height: 28.h, fit: BoxFit.scaleDown),
                      SizedBox(width: 15.w),
                      SvgPicture.asset('assets/svg/icons/reload-icon.svg',
                          height: 28.h, fit: BoxFit.scaleDown),
                    ],
                  ),
                  Spacer(),
                  Flexible(
                    flex: 1,
                    child: MaterialButton(
                      height: 30.h,
                      elevation: 0,
                      color: Color(0xffF1F1F1),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xffBBBBBB)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Hourly",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: Color(0xff232226),
                                    fontWeight: FontWeight.w600)),
                          ),
                          SvgPicture.asset('assets/svg/icons/dropdown.svg',
                              height: 15.h, fit: BoxFit.scaleDown),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                getGradientProgressStyle("CPU Usage", 70),
                getGradientProgressStyle("Disk Operation", 40)
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                getGradientProgressStyle("Network", 56),
                getGradientProgressStyle("Memory", 80)
              ]),
              SizedBox(height: 30),
              rowSpec("Location", "Jakarta"),
              rowSpec("IP Address", "-"),
              rowSpec("Username", "Administrator"),
              rowSpec("Hostname", "didanalzabar91"),
              rowSpec("CPU", "1 CPU"),
              rowSpec("RAM", "1024 MB"),
              rowSpec("Storage", "20 GB"),
              rowSpec("OS", "Windows 2022"),
              rowSpec("Price Per Hour", "Rp 0,00"),
              rowSpec("Estimated Monthly Cost", "Rp 0,00"),
              rowSpec("Private Network", "-"),
              rowSpec("Created at", "13 August 2023 21:54:40"),
              rowSpec("Last Started at", "14 August 2023 22:49:48"),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                width: ScreenUtil().screenWidth,
                height: 250,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xffbbbbbb), width: 1),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                    child: CustomLineChart.buildDefaultLineChart(chartData)),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }

  Widget rowSpec(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xffBBBBBB),
                      fontWeight: FontWeight.w500)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              ": $value",
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xff232226),
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget getGradientProgressStyle(String title, double percent) {
    return SizedBox(
        height: 160,
        width: 160,
        child: SfRadialGauge(axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: false,
              startAngle: 270,
              endAngle: 270,
              radiusFactor: 0.8,
              axisLineStyle: AxisLineStyle(
                thickness: 0.2,
                color: Colors.grey.shade200,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                    cornerStyle: CornerStyle.bothCurve,
                    value: percent,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationType: AnimationType.linear,
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFFD0EDFF), Color(0xFF009EFF)],
                        stops: <double>[0.25, 0.75])),
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(
                    positionFactor: 0.1,
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xffBBBBBB),
                                  fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          percent.toStringAsFixed(0) + '%',
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xff009EFF),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ))
              ]),
        ]));
  }
}
