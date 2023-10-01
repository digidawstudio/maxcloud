import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InstanceCreateScreen extends StatefulWidget {
  const InstanceCreateScreen({super.key});

  @override
  State<InstanceCreateScreen> createState() => _InstanceCreateScreenState();
}

class _InstanceCreateScreenState extends State<InstanceCreateScreen> {
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
            Text("Instance",
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
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Create Virtual Machine",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffbbbbbb),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF1F1F1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                                  'assets/svg/flags/indonesia.svg',
                                  height: 17,
                                  fit: BoxFit.scaleDown)))),
                  VerticalDivider(
                    thickness: 1,
                    width: 0,
                    color: const Color(0xffbbbbbb),
                  ),
                  Expanded(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Indonesia",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          color: Color(0xffBBBBBB),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400))),
                              Text("Jakarta DC1",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          color: Color(0xff232226),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)))
                            ]),
                      ))
                ]),
              ),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Tier",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffbbbbbb),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                            'assets/svg/icons/chart-icon.svg',
                            height: 18,
                            fit: BoxFit.scaleDown),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Optimized Cloud Compute",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff232226),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(height: 5),
                            Text(
                                "Dengan komputasi tingkat tinggi yang akan menciptakan peluang tanpa batas",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff959595),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)))
                          ],
                        ),
                      )
                    ]),
              ),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Operating System",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 15),
              osList()
            ],
          ),
        ),
      )),
    );
  }

  Widget osList() {
    return Column(children: [
      Row(
        children: [osItem(), SizedBox(width: 20), osItem()],
      ),
      SizedBox(height: 20),
      Row(
        children: [osItem(), SizedBox(width: 20), osItem()],
      ),
      SizedBox(height: 20),
      Row(
        children: [osItem(), SizedBox(width: 20), osItem()],
      ),
    ]);
  }

  Widget osItem() {
    return Flexible(
      flex: 1,
      child: Container(
        height: 41,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xffF1F1F1),
            border: Border.all(
              color: const Color(0xffbbbbbb),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Image.asset(
            "assets/images/icons/ubuntu.png",
            height: 20,
          ),
          SizedBox(width: 10),
          Text("Ubuntu",
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      color: Color(0xff232226),
                      fontSize: 12,
                      fontWeight: FontWeight.w600)))
        ]),
      ),
    );
  }
}
