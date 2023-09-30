import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWidget {
  static Widget Chip(
      {String? text,
      double? height,
      Color? textColor,
      double? width,
      Color color = Colors.white,
      double radius = 6,
      double? fontSize,
      bool useBorder = false}) {
    return Container(
      height: height?.h,
      width: width?.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius.r),
        border: !useBorder ? null : Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          text ?? "",
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: fontSize?.sp ?? 12.sp,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
