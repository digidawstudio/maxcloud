import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indexed/indexed.dart';
import 'package:maxcloud/screens/home/notification/notification.screen.dart';
import 'package:maxcloud/utils/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
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
                      color: Color.fromARGB(255, 227, 227, 227),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Current Cost"),
                        Text(
                          "Rp 0,00",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text("Estimated Monthly Cost"),
                        Text("Rp 100.000.000,00",
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Container(
                    height: 230.h,
                    width: ScreenUtil().screenWidth,
                    padding: EdgeInsets.symmetric(horizontal: 31.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: const Color(0xff009EFF),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 20)
                        ]),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Image(
                                  image:
                                      AssetImage("assets/images/maxcloud.png")),
                              Expanded(child: Container()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
                                },
                                child: Icon(Icons.notifications_active_rounded,
                                    color: Colors.white, size: 20.w),
                              ),
                              SizedBox(
                                width: 12.w,
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.red,
                              )
                            ],
                          ),
                          Flexible(
                              child: SizedBox(
                            height: 12.h,
                          )),
                          Flexible(
                              child: Text(
                            "Selamat Datang Babang",
                            style:
                                TextStyle(color: Colors.white, fontSize: 10.sp),
                          )),
                          Flexible(
                              child: SizedBox(
                            height: 12.h,
                          )),
                          Container(
                            height: 79.h,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 10.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "Saldo Anda",
                                        style: TextStyle(
                                            color: const Color(0xffBBBBBB),
                                            fontSize: 12.sp),
                                      )),
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
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20.sp),
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Text(
                                              "123.456",
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff009eff),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30.sp),
                                            ),
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
                  ),
                ],
              ),
            ),
            ResourceWidget(
                child: ResourceItem(
                    title: "Total Resource",
                    amount: "8",
                    iconPath: "assets/icons/cloud-notif.png",
                    percentage: "+6,32%")),
            ResourceWidget(
                child: ResourceItem(
                    title: "Running Resource",
                    amount: "8",
                    iconPath: "assets/icons/running-resource.png",
                    percentage: "+6,32%")),
            ResourceWidget(
                child: ResourceItem(
              title: "Stopped Resource",
              amount: "2",
              iconPath: "assets/icons/stopped-resource.png",
              percentage: "+6,32%",
            )),
            InstanceSpecs()
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
          border: Border.all(color: const Color(0xffbbbbbb)),
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
            Text(title ?? ""),
            Expanded(child: Container()),
            Image.asset(iconPath!)
          ],
        ),
        Expanded(child: Container()),
        Row(
          children: [
            Text(
              amount ?? "",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            Expanded(child: Container()),
            CustomWidget.Chip(
              text: percentage ?? "",
              color: Color(0xffE7F6FF),
            )
          ],
        )
      ],
    );
  }
}
