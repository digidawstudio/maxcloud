import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';
import 'package:maxcloud/bloc/billing/month-summary.bloc.dart';
import 'package:maxcloud/screens/home/notification/notification.screen.dart';
import 'package:maxcloud/utils/widgets.dart';

import '../../bloc/profile/profile.bloc.dart';
import '../instance/instance.detail.screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MonthSummaryBloc? monthSummaryBloc;
  ProfileBloc? profileBloc;
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    monthSummaryBloc = BlocProvider.of<MonthSummaryBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    getAccessToken();
    super.initState();
  }

  void getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    monthSummaryBloc?.add(FetchCurrentMonthSummaryEvent(accessToken ?? ""));
    profileBloc?.add(FetchProfileEvent(accessToken ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<MonthSummaryBloc, MonthSummaryState>(
                builder: (context, state) {
              if (state is LoadedMonthSummaryState) {
                return Container(
                  height: 400.h,
                  child: Stack(
                    children: [
                      Container(
                        transform: Matrix4.translationValues(0, 200.h, 0),
                        height: 188.h,
                        width: ScreenUtil().screenWidth,
                        padding: EdgeInsets.only(
                            left: 31.w, right: 31.w, top: 50.h, bottom: 23.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: Color.fromARGB(255, 235, 235, 235),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("Current Cost",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 10.sp,
                                        color: Color(0xff232226),
                                        fontWeight: FontWeight.w500))),
                            RichText(
                                text: TextSpan(
                                    text: "Rp ",
                                    style: GoogleFonts.manrope(
                                        textStyle: TextStyle(
                                            fontSize: 20.sp,
                                            color: Color(0xff232226),
                                            fontWeight: FontWeight.w400)),
                                    children: [
                                  TextSpan(
                                      text:
                                          "${state.data.data?.currentCost},00",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Color(0xff232226),
                                          fontWeight: FontWeight.w700))
                                ])),
                            Expanded(child: Container()),
                            Text("Estimated Monthly Cost",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 10.sp,
                                        color: Color(0xff232226),
                                        fontWeight: FontWeight.w500))),
                            RichText(
                                text: TextSpan(
                                    text: "Rp ",
                                    style: GoogleFonts.manrope(
                                        textStyle: TextStyle(
                                            fontSize: 20.sp,
                                            color: Color(0xff232226),
                                            fontWeight: FontWeight.w400)),
                                    children: [
                                  TextSpan(
                                      text:
                                          "${state.data.data?.estimatedMonthlyTotal},00",
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Color(0xff232226),
                                          fontWeight: FontWeight.w700))
                                ])),
                          ],
                        ),
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                        if (state is LoadedProfileState) {
                          return Container(
                            height: 242.h,
                            width: ScreenUtil().screenWidth,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30.w, vertical: 25.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.r),
                                    bottomRight: Radius.circular(15.r)),
                                color: const Color(0xff009EFF),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 20)
                                ]),
                            child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Image(
                                          height: 26,
                                          image: AssetImage(
                                              "assets/images/maxcloud.png")),
                                      Expanded(child: Container()),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NotificationScreen()));
                                        },
                                        child: Icon(
                                            Icons.notifications_active_rounded,
                                            color: Colors.white,
                                            size: 20.w),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  Flexible(
                                      child: RichText(
                                          text: TextSpan(
                                              text: "Selamat Datang ",
                                              style: GoogleFonts.manrope(
                                                  textStyle: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              children: [
                                        TextSpan(
                                            text:
                                                "${state.data.data?.fullName}!",
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700))
                                      ]))),
                                  Flexible(
                                      child: SizedBox(
                                    height: 12.h,
                                  )),
                                  Container(
                                    height: 80.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Flexible(
                                                  child: Text("Saldo Anda",
                                                      style: GoogleFonts.manrope(
                                                          textStyle: TextStyle(
                                                              fontSize: 12.sp,
                                                              color: Color(
                                                                  0xffBBBBBB),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)))),
                                              SizedBox(
                                                height: 2.h,
                                              ),
                                              Flexible(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Rp",
                                                      style: GoogleFonts.manrope(
                                                          textStyle: TextStyle(
                                                              fontSize: 20.sp,
                                                              color: Color(
                                                                  0xff232226),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    SizedBox(
                                                      width: 7.w,
                                                    ),
                                                    Text(
                                                        state.data.data
                                                                ?.currentBalance
                                                                .toString() ??
                                                            "0",
                                                        style: GoogleFonts.manrope(
                                                            textStyle: TextStyle(
                                                                fontSize: 20.sp,
                                                                color: Color(
                                                                    0xff009EFF),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            //TODO: add function
                                          },
                                          child: const Image(
                                            image: AssetImage(
                                                "assets/images/add-button.png"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
            ResourceWidget(
                child: ResourceItem(
                    title: "Total Resource",
                    amount: "8",
                    iconPath: 'assets/svg/icons/cloud-circle.svg',
                    percentage: "+6,32%")),
            ResourceWidget(
                child: ResourceItem(
                    title: "Running Resource",
                    amount: "8",
                    iconPath: 'assets/svg/icons/stat-circle.svg',
                    percentage: "+6,32%")),
            ResourceWidget(
                child: ResourceItem(
              title: "Stopped Resource",
              amount: "2",
              iconPath: 'assets/svg/icons/guard-circle.svg',
              percentage: "+6,32%",
            )),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 28),
            //   child: CustomWidget.InstanceSpecs(() {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => InstanceDetailScreen()));
            //   }),
            // ),
            SizedBox(height: 40.h)
          ],
        ),
      ),
    );
  }

  Widget ResourceWidget(
      {double height = 75, required Widget child, EdgeInsets? padding}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 26.w, vertical: 10.h),
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      height: height.h,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffbbbbbb), width: 0.5),
          borderRadius: BorderRadius.circular(10.r)),
      child: child,
    );
  }

  Widget InstanceSpecs() {
    return ResourceWidget(
      height: 172,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 30.h,
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "20GB Regular Cloud Compute",
                      style:
                          TextStyle(fontSize: 8.sp, color: Color(0xffbbbbbb)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Mark Zuckerberg",
                      style:
                          TextStyle(fontSize: 12.sp, color: Color(0xff009EFF)),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                VerticalDivider(
                  color: Colors.black,
                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "IP Address",
                      style:
                          TextStyle(fontSize: 8.sp, color: Color(0xffbbbbbb)),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "127.0.0.1",
                      style:
                          TextStyle(fontSize: 12.sp, color: Color(0xff009EFF)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xffbbbbbb),
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.all(10.0.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Status",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffbbbbbb),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Running",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 156, 255, 150),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffbbbbbb),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Jakarta",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OS",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffbbbbbb),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Windos",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0.h),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price Per Hour",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffbbbbbb),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Rp 100.000",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Cost",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xffbbbbbb),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Rp 999.999.999",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: 19.w,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ResourceItem(
      {String? title, String? iconPath, String? amount, String? percentage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title ?? "",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        fontSize: 12.sp,
                        color: Color(0xffBBBBBB),
                        fontWeight: FontWeight.w600))),
            Expanded(child: Container()),
            SvgPicture.asset(iconPath!, height: 18, fit: BoxFit.scaleDown)
          ],
        ),
        Expanded(child: Container()),
        Row(
          children: [
            Text(
              amount ?? "",
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Color(0xff232226),
                  fontWeight: FontWeight.w600),
            ),
            Expanded(child: Container()),
            CustomWidget.Chip(
              width: 46,
              height: 16,
              text: percentage ?? "",
              color: Color(0xffE7F6FF),
            )
          ],
        )
      ],
    );
  }
}
