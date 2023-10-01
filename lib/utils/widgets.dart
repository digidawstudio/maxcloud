import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWidget {
  static Widget Chip(
      {String? text,
      double? height,
      double? width,
      Color color = Colors.white,
      double radius = 6}) {
    return Container(
      height: height?.h,
      width: width?.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(radius.r)),
      child: Text(text ?? ""),
    );
  }

  static Widget ResourceWidget(
      {double height = 75, required Widget child, EdgeInsets? padding}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
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

  static Widget InstanceSpecs(Function() onPressInstance) {
    return GestureDetector(
      onTap: onPressInstance,
      child: ResourceWidget(
        height: 172,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Container(
              height: 30.h,
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "20GB Regular Cloud Compute",
                            style: TextStyle(
                                fontSize: 8.sp, color: Color(0xffbbbbbb)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Mark Zuckerberg",
                            style: TextStyle(
                                fontSize: 12.sp, color: Color(0xff009EFF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  VerticalDivider(
                    thickness: 0.5,
                    color: Color(0xffbbbbbb),
                  ),
                  SizedBox(width: 15.w),
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            "IP Address",
                            style: TextStyle(
                                fontSize: 8.sp, color: Color(0xffbbbbbb)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "127.0.0.1",
                            style: TextStyle(
                                fontSize: 12.sp, color: Color(0xff009EFF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0xffbbbbbb),
              thickness: 0.5,
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
      ),
    );
  }
}
