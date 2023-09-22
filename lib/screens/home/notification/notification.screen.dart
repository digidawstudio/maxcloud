import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenStateState();
}

class _NotificationScreenStateState extends State<NotificationScreen> {

  int currentActive = 0; // 0 for general 1 for service

  List generalNotification = [
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
  ];
  
  List serviceNotification = [
    "Virtual Machine Created",
    "Virtual Machine Created",
    "Virtual Machine Created",
    "Virtual Machine Created",
    "Virtual Machine Created",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Notifications",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 10.r,
              backgroundColor: Colors.red,
              child: Center(child: Text("5", style: TextStyle(color: Colors.white),)),
            ),
          ),
          SizedBox(width: 19.w,)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            borderRadius: BorderRadius.circular(5.r),
            elevation: 3,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          currentActive = 0;
                        }),
                        child: ToggleButton("General")
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () => setState(() {
                          currentActive = 1;
                        }),
                        child: ToggleButton("Service")
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Text(
                    "Mark all as read",
                    style: TextStyle(
                        color: Colors.lightBlue, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: currentActive == 0 ? generalNotification.length : serviceNotification.length,
              shrinkWrap: true,
              itemBuilder: (context, i) => NotificationItem(currentActive == 0 ? generalNotification[i] : serviceNotification[i]),
            ),
          )
        ],
      ),
    );
  }

  Widget NotificationItem(String title) {
    return Container(
      height: 103.h,
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      color: Color(0xfff1f1f1f1),
      child: Column(
        children: [
          Row(
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),),
              Expanded(child: Container()),
              Text("2 days ago", style: TextStyle(fontSize: 10.sp, color: Color(0xffbbbbbb)),)
            ],
          ),
          Expanded(child: Container()),
          Text("Dear Didan Alzabar, Rp50000 has been added to your balance", style: TextStyle(color: Color(0xffbbbbbb), fontSize: 12.sp),),
        ],
      ),
    );
  }

  Widget ToggleButton(String type) {
    return Material(
      borderRadius: BorderRadius.circular(10.r),
      color: currentActive == 0 && type == "General" ? Color(0xff009EFF) : currentActive == 1 && type == "Service" ? Color(0xff009EFF) : Color(0xf1f1f1f1),
      child: Container(
        height: 39.h,
        width: 140.w,
        child: Center(
            child: Text(
          type,
          style: TextStyle(color: currentActive == 0 && type == "General" ? Colors.white : currentActive == 1 && type == "Service" ? Colors.white : Color(0xffbbbbbb), fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
