import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/utils/widgets.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({super.key});

  @override
  State<HelpDeskScreen> createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  List defaultState = [
    "test",
    "test",
    "test",
    "test",
    "test",
    "test",
  ];

  List savedState = [
    "test",
    "test",
    "test",
  ];

  bool isSavedPressed = false;

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
            Text(isSavedPressed ? "Saved" : "Help Desk",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSavedPressed = !isSavedPressed;
                });
              },
              icon: Image.asset(
                "assets/icons/bookmark.png",
                color: isSavedPressed ? Colors.transparent : Color(0xff232226),
              ))
        ],
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
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 13.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ButtonTheme(
                      minWidth: 171.w,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "+ New Ticket",
                          style:
                              TextStyle(color: Colors.white, fontSize: 14.sp),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff009Eff)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  height: ScreenUtil().screenHeight,
                  child: ListView.builder(
                    // shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 15.h,
                    ),
                    itemCount: isSavedPressed
                        ? savedState.length
                        : defaultState.length,
                    itemBuilder: (context, i) => helpdeskItems(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget helpdeskItems() {
    return SimpleShadow(
      opacity: 0.3, // Default: 0.5
      color: Colors.grey, // Default: Black
      offset: Offset(0, 5), // Default: Offset(2, 2)
      sigma: 7, // Default: 2
      child: Container(
        height: 184.h,
        margin: EdgeInsets.only(bottom: 25.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Free Delivery",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Color(0xff232226),
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      "19 September 2023",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Color(0xffBBBBBB),
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                Container(
                  width: 30.w,
                  child: Stack(
                    children: [
                      Positioned(
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 10.r,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10.r,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 7.w,
                ),
                Icon(Icons.bookmark)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo.",
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      color: Color(0xffBBBBBB),
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ),
            Expanded(child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.comment),
                SizedBox(
                  width: 4.w,
                ),
                Text(
                  "4",
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Color(0xff232226),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(child: Container()),
                Flexible(
                    child: CustomWidget.Chip(
                        text: "Open",
                        width: 48,
                        height: 14,
                        color: Color(0xffE9FCE5),
                        radius: 5.r,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: Color(0xff02D430))),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                    child: CustomWidget.Chip(
                        text: "Support",
                        width: 48,
                        height: 14,
                        color: Color(0xffAABDFF),
                        radius: 5.r,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: Color(0xff18369E))),
                SizedBox(
                  width: 10.w,
                ),
                CustomWidget.Chip(
                  text: "Virtual Machine",
                  width: 70,
                  height: 14,
                  fontSize: 8,
                  color: Colors.white,
                  radius: 5.r,
                  useBorder: true,
                  fontWeight: FontWeight.w500,
                  textColor: Color(0xff232226),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
