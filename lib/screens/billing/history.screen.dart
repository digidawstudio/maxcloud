import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Payment History",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
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
          color: Colors.white,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 26.h),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: MaterialButton(
                          minWidth: 219.w,
                          height: 30.h,
                          elevation: 0,
                          color: const Color(0xff009EFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SvgPicture.asset('assets/svg/icons/plus-icon.svg',
                              //     height: 11.h, fit: BoxFit.scaleDown),
                              SizedBox(width: 12.w),
                              Text(
                                "08/16/2023 -08/16/2023",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  )),
              SizedBox(
                height: 19.h,
              ),
              Flexible(
                child: SizedBox(
                  height: ScreenUtil().screenHeight,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 26.w, right: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 212.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 28.h),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffbbbbbb), width: 1),
                              borderRadius: BorderRadius.circular(15.r)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Account Balance",
                                style: GoogleFonts.manrope(
                                    textStyle: const TextStyle(
                                        color: Color(0xffBBBBBB),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    children: [
                                      const TextSpan(text: "Rp "),
                                      TextSpan(
                                          text: "0 ,00",
                                          style: GoogleFonts.manrope(
                                              textStyle: const TextStyle(
                                                  color: Color(0xff009EFF),
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ]),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "Charge This Month",
                                style: GoogleFonts.manrope(
                                    textStyle: const TextStyle(
                                        color: Color(0xffBBBBBB),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    children: [
                                      const TextSpan(text: "Rp "),
                                      TextSpan(
                                          text: "100.000.000,00",
                                          style: GoogleFonts.manrope(
                                              textStyle: const TextStyle(
                                                  color: Color(0xff009EFF),
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ]),
                              ),
                              Expanded(child: Container()),
                              Text(
                                "Estimated Balance",
                                style: GoogleFonts.manrope(
                                    textStyle: const TextStyle(
                                        color: Color(0xffBBBBBB),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    children: [
                                      const TextSpan(text: "Rp "),
                                      TextSpan(
                                          text: "100.000.000,00",
                                          style: GoogleFonts.manrope(
                                              textStyle: const TextStyle(
                                                  color: Color(0xff009EFF),
                                                  fontSize: 20,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(100, (_) => [])
                              .map((e) => items())
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget items() {
    return SimpleShadow(
      opacity: 0.3, // Default: 0.5
      color: Colors.grey, // Default: Black
      offset: const Offset(0, 5), // Default: Offset(2, 2)
      sigma: 7, // Default: 2
      child: Container(
        height: 65.h,
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Up",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Color(0xff009EFF),
                          fontSize: 12,
                          fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "BCA 123456992",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Color(0xffBBBBBB),
                          fontSize: 10,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            Expanded(child: Container()),
            Text("-Rp 50.000",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff232226),
                        fontSize: 12,
                        fontWeight: FontWeight.w700)))
          ],
        ),
      ),
    );
  }
}
