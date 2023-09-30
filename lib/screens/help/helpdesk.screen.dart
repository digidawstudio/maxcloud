import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxcloud/utils/widgets.dart';

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text( isSavedPressed ? "SAVED" : "HELP DESK"),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSavedPressed = !isSavedPressed;
                });
              },
              icon: Image.asset(
                "assets/icons/bookmark.png",
                color: isSavedPressed ? Colors.black : Colors.white,
              ))
        ],
      ),
      body: Container(
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
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff009Eff)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
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
                  itemCount: isSavedPressed ? savedState.length : defaultState.length,
                  itemBuilder: (context, i) => helpdeskItems(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget helpdeskItems() {
    return Container(
      height: 184.h,
      margin: EdgeInsets.only(bottom: 25.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 2.5,
                color: Colors.grey,
                spreadRadius: .5)
          ]),
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
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "19 September 2023",
                    style: TextStyle(fontSize: 10.sp),
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
            style: TextStyle(fontSize: 12.sp, color: Color(0xffBBBBBB)),
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
                style: TextStyle(fontSize: 12.sp),
              ),
              Expanded(child: Container()),
              Flexible(
                  child: CustomWidget.Chip(
                      text: "Open",
                      width: 48,
                      height: 20,
                      color: Color(0xffE9FCE5),
                      radius: 5.r,
                      fontSize: 8,
                      textColor: Color(0xff02D430))),
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                  child: CustomWidget.Chip(
                      text: "Support",
                      width: 48,
                      height: 20,
                      color: Color(0xffAABDFF),
                      radius: 5.r,
                      fontSize: 8,
                      textColor: Colors.black)),
              SizedBox(
                width: 10.w,
              ),
              CustomWidget.Chip(
                text: "Virtual Machine",
                width: 70,
                height: 20,
                fontSize: 8,
                color: Colors.white,
                radius: 5.r,
                useBorder: true,
                textColor: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
