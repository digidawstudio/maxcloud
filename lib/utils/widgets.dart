import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/repository/instances/my-virtual-machines.model.dart';

class CustomWidget {

  static Widget loader() {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      color: Colors.grey.withOpacity(0.5),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  static Widget Chip(
      {String? text,
      double? height,
      Color? textColor,
      double? width,
      Color color = Colors.white,
      double radius = 6,
      double? fontSize,
      FontWeight? fontWeight,
      bool useBorder = false}) {
    return Container(
      height: height?.h,
      width: width?.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius.r),
        border: !useBorder
            ? null
            : Border.all(color: Color(0xffBBBBBB), width: 0.5),
      ),
      child: Center(
        child: Text(
          text ?? "",
          style: TextStyle(
              fontSize: fontSize?.sp ?? 10.sp,
              color: textColor ?? Color(0xff232226),
              fontWeight: fontWeight ?? FontWeight.w600),
          maxLines: 1,
        ),
      ),
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

  static Widget InstanceSpecs(Function() onPressInstance, {InstanceData? data}) {
    return GestureDetector(
      onTap: onPressInstance,
      child: ResourceWidget(
        height: 172.h,
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
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data!.tier!,
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    color: Color(0xffBBBBBB),
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(height: 5.h),
                          Flexible(
                            child: Text(
                              data.owner!,
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff009EFF),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "IP Address",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    color: Color(0xffBBBBBB),
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Flexible(
                            child: Text(
                              data.ipAddress!,
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff009EFF),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600)),
                            ),
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
                      Text(data.status!,
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600))),
                      Text("Running",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff00FF38),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Location",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600))),
                      Text(data.location!,
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("OS",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600))),
                      Image.network(
                        data.os!.image!,
                        height: 22,
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
                      Text("Price Per Hour",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600))),
                      Text("Rp ${data.pricePerHour!.floor()}",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Current Cost",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600))),
                      Text("Rp ${data.estimatedMonthlyCost!.floor()}",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600))),
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
