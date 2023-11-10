import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/bloc/product/rrd-data.bloc.dart';
import 'package:maxcloud/bloc/product/vm-state.bloc.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';
import 'package:maxcloud/repository/instances/rrd-data.model.dart';
import 'package:maxcloud/screens/instance/components/line.chart.dart';
import 'package:maxcloud/utils/widgets.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../bloc/product/product.bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/product/vm-detail.bloc.dart';

class InstanceDetailScreen extends StatefulWidget {
  final InstanceData data;
  const InstanceDetailScreen({super.key, required this.data});

  @override
  State<InstanceDetailScreen> createState() => _InstanceDetailScreenState();
}

class _InstanceDetailScreenState extends State<InstanceDetailScreen> {
  List<ChartData>? chartData;
  List<ChartData> cpuData = [];
  List<ChartData> memoryData = [];
  List<ChartData> networkData = [];
  List<ChartData> diskData = [];

  int cpuPercentage = 0;
  int memoryPercentage = 0;
  int networkPercentage = 0;
  int diskPercentage = 0;

  String period = 'hour';
  String token = '';

  final storage = new FlutterSecureStorage();

  VMDetailBloc? vmDetailBloc;
  RRDDataBloc? rrdDataBloc;
  VMStateBloc? vmStateBloc;

  @override
  void initState() {
    vmDetailBloc = BlocProvider.of<VMDetailBloc>(context);
    rrdDataBloc = BlocProvider.of<RRDDataBloc>(context);
    vmStateBloc = BlocProvider.of<VMStateBloc>(context);

    getAccessToken();
    manipulateRRD();
    super.initState();
  }

  DateTime convertTimeStringToDateTime(String timeString) {
    return DateTime.parse(timeString);
  }

  startVM() {
    vmStateBloc?.add(StartVMEvent(token, widget.data.uuid!));
  }

  restartVM() {
    vmStateBloc?.add(RestartVMEvent(token, widget.data.uuid!));
  }

  shutdownVM() {
    vmStateBloc?.add(ShutdownVMEvent(token, widget.data.uuid!));
  }

  getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');

    vmDetailBloc?.add(FetchVMDetailEvent(accessToken ?? "", widget.data.uuid));
    rrdDataBloc
        ?.add(FetchRRDDataEvent(accessToken ?? "", widget.data.uuid, period));
    setState(() {
      token = accessToken!;
    });
  }

  manipulateRRD() async {
    RRDDataState rrdDataState = BlocProvider.of<RRDDataBloc>(context).state;

    if (rrdDataState is LoadedRRDDataState) {
      LoadedRRDDataState data =
          BlocProvider.of<RRDDataBloc>(context).state as LoadedRRDDataState;

      // Ambil data CPU
      if (data.rrdData.data?.cpu != null &&
          data.rrdData.data?.cpu?.length != 0) {
        final Cpu? latestCpuData = data.rrdData.data?.cpu?[0];
        final double? percentage = latestCpuData?.cpu;
        cpuData = (data.rrdData.data?.cpu as List).map((item) {
          return ChartData(
              convertTimeStringToDateTime(item.time), item.cpu.toDouble());
        }).toList();
        cpuPercentage = percentage!.toInt();
      }

      // Ambil data Memory
      if (data.rrdData.data?.memory != null &&
          data.rrdData.data?.memory?.length != 0) {
        final Memory? latestMemoryData = data.rrdData.data?.memory?[0];
        final double? maxMemory = latestMemoryData?.rawMaxMemory;
        final double? usageMemory = latestMemoryData?.rawUsageMemory;
        final double percentage = (usageMemory! / maxMemory!) * 100.0;

        memoryData = (data.rrdData.data?.memory as List).map((item) {
          return ChartData(convertTimeStringToDateTime(item.time),
              item.rawUsageMemory.toDouble());
        }).toList();
        memoryPercentage = percentage.toInt();
      }

      // Ambil data Network
      if (data.rrdData.data?.network != null &&
          data.rrdData.data?.network?.length != 0) {
        networkData = (data.rrdData.data?.network as List).map((item) {
          return ChartData(convertTimeStringToDateTime(item.time),
              item.rawNetout.toDouble());
        }).toList();
      }

      // Ambil data Disk
      if (data.rrdData.data?.disk != null &&
          data.rrdData.data?.disk?.length != 0) {
        diskData = (data.rrdData.data?.disk as List).map((item) {
          return ChartData(convertTimeStringToDateTime(item.time),
              item.rawDiskRead.toDouble());
        }).toList();
      }

      setState(() {});
    }
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
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
              height: 24, fit: BoxFit.scaleDown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<VMStateBloc, VMState>(builder: (context, state) {
        if (state is LoadedVMState) {
          vmDetailBloc?.add(FetchVMDetailEvent(token, widget.data.uuid));
        }

        return SafeArea(
            child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 22),
                    BlocBuilder<VMDetailBloc, VMDetailState>(
                        builder: (context, state) {
                      if (state is LoadedVMDetailState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/icons/windows.png",
                                  height: 48,
                                ),
                                SizedBox(width: 12),
                                Text(state.vmDetail.data?.hostname ?? "",
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
                                color: (state.vmDetail.data?.status ==
                                            'Starting' ||
                                        state.vmDetail.data?.status ==
                                            'Stopping')
                                    ? Color.fromARGB(255, 236, 228, 8)
                                    : state.vmDetail.data?.status == 'Stopped'
                                        ? Color.fromARGB(255, 216, 58, 19)
                                        : Color(0xff02D430),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "●  ${state.vmDetail.data?.status ?? "-"}",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: SvgPicture.asset(
                                  'assets/svg/icons/monitor-icon.svg',
                                  height: 28.h,
                                  fit: BoxFit.scaleDown),
                            ),
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () => shutdownVM(),
                              child: SvgPicture.asset(
                                  'assets/svg/icons/power-icon.svg',
                                  height: 28.h,
                                  fit: BoxFit.scaleDown),
                            ),
                            SizedBox(width: 15.w),
                            GestureDetector(
                              onTap: () => startVM(),
                              child: SvgPicture.asset(
                                  'assets/svg/icons/reload-icon.svg',
                                  height: 28.h,
                                  fit: BoxFit.scaleDown),
                            )
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
                              side: BorderSide(
                                  width: 1, color: Color(0xffBBBBBB)),
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
                                SvgPicture.asset(
                                    'assets/svg/icons/dropdown.svg',
                                    height: 15.h,
                                    fit: BoxFit.scaleDown),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      getGradientProgressStyle(
                          "CPU Usage", cpuPercentage.toDouble()),
                      getGradientProgressStyle(
                          "Disk Operation", diskPercentage.toDouble())
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      getGradientProgressStyle(
                          "Network", networkPercentage.toDouble()),
                      getGradientProgressStyle(
                          "Memory", memoryPercentage.toDouble())
                    ]),
                    SizedBox(height: 30),
                    BlocBuilder<VMDetailBloc, VMDetailState>(
                        builder: (context, state) {
                      if (state is LoadedVMDetailState) {
                        return Column(
                          children: [
                            rowSpec("Location",
                                state.vmDetail.data?.location ?? "-"),
                            rowSpec("IP Address",
                                state.vmDetail.data?.ipAddress ?? "-"),
                            rowSpec("Username",
                                state.vmDetail.data?.username ?? "-"),
                            rowSpec("Hostname",
                                state.vmDetail.data?.hostname ?? "-"),
                            rowSpec("CPU", state.vmDetail.data?.cpu ?? "-"),
                            rowSpec("RAM", state.vmDetail.data?.memory ?? "-"),
                            rowSpec(
                                "Storage", state.vmDetail.data?.storage ?? "-"),
                            rowSpec("OS", state.vmDetail.data?.osName ?? "-"),
                            rowSpec(
                              "Price Per Hour",
                              "Rp " +
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: "",
                                    decimalDigits: 0,
                                  ).format(
                                      state.vmDetail.data?.pricePerHour ?? 0) +
                                  ",00",
                              // "Rp ${state.vmDetail.data?.pricePerHour ?? 0}"
                            ),
                            rowSpec(
                              "Estimated Monthly Cost",
                              "Rp " +
                                  NumberFormat.currency(
                                    locale: 'id',
                                    symbol: "",
                                    decimalDigits: 0,
                                  ).format(state.vmDetail.data
                                          ?.estimatedMonthlyPrice ??
                                      0) +
                                  ",00",
                              // "Rp ${state.vmDetail.data?.estimatedMonthlyPrice ?? 0}"
                            ),
                            rowSpec("Private Network",
                                state.vmDetail.data?.privateNetwork ?? "-"),
                            rowSpec("Created at",
                                state.vmDetail.data?.createdAt ?? "-"),
                            rowSpec("Last Started at",
                                state.vmDetail.data?.lastStartedAt ?? "-"),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      width: ScreenUtil().screenWidth,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffbbbbbb), width: 1),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                          child: CustomLineChart.buildDefaultLineChart(
                              'CPU Usage', cpuData)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      width: ScreenUtil().screenWidth,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffbbbbbb), width: 1),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                          child: CustomLineChart.buildDefaultLineChart(
                              'Memory Usage', memoryData)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      width: ScreenUtil().screenWidth,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffbbbbbb), width: 1),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                          child: CustomLineChart.buildDefaultLineChart(
                              'Network Usage', networkData)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      width: ScreenUtil().screenWidth,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0xffbbbbbb), width: 1),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                          child: CustomLineChart.buildDefaultLineChart(
                              'Disk Usage', diskData)),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            state is LoadingVMState
                ? Container(
                    height: ScreenUtil().screenHeight,
                    width: ScreenUtil().screenWidth,
                    color: Colors.grey.withOpacity(0.6),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container()
          ],
        ));
      }),
    );
  }

  Widget rowSpec(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
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
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 3,
            child: Text(
              ":  $value",
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
