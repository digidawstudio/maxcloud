import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/widgets.dart';

class HelpDeskDetailScreen extends StatefulWidget {
  const HelpDeskDetailScreen({super.key});

  @override
  State<HelpDeskDetailScreen> createState() => _HelpDeskDetailScreenState();
}

class _HelpDeskDetailScreenState extends State<HelpDeskDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.opaque,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Help Desk",
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60.h,
        child: ButtonTheme(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  enableDrag: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Container(
                      height: 500.h,
                      padding: EdgeInsets.all(25.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Enter Subject"),
                          SizedBox(
                            height: 9.h,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Free Delivery",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.r))),
                          ),
                          SizedBox(height: 10.h,),
                          Flexible(
                            child: Container(
                              height: 100.h,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Select Department"),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText: "Billing",
                                            border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20.w,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Select Department"),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                            hintText: "Billing",
                                            border: OutlineInputBorder(
                                              borderSide:
                                                  BorderSide(color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Text("Reply"),
          ),
        ),
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25.w),
              width: ScreenUtil().screenWidth,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Free Delivery",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 11.w,
                          ),
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
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("19 September 2023"),
                          SizedBox(
                            width: 12.w,
                          ),
                          Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text("08:00"),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 200.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/icons/message.svg',
                          height: 15, fit: BoxFit.fill),
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
                    ],
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1.5,
              color: Color(0xffF1F1F1),
              height: 0,
            ),
            Flexible(
              child: Container(
                height: ScreenUtil().screenHeight,
                child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 128.h,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Color(0xffF1F1F1), width: 1.5),
                          ),
                        ),
                        padding: EdgeInsets.all(25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 15.r,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "Didan Alzabar",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(child: Container()),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "19 September 2023",
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      "08:00",
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Flexible(
                                child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo.",
                              style: TextStyle(
                                  color: Color(0xffbbbbbb), fontSize: 10.sp),
                            ))
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
