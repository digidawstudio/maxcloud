import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomWidget {
  static Widget Chip({String? text, double? height, double? width, Color color = Colors.white, double radius = 6}) {
    return Container(
      height: height?.h,
      width: width?.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius.r)
      ),
      child: Text(text ?? ""),
    );
  }
}