import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/screens/instance/instance.create.screen.dart';
import 'package:maxcloud/screens/instance/instance.detail.screen.dart';
import 'package:maxcloud/utils/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class InstanceScreen extends StatefulWidget {
  const InstanceScreen({super.key});

  @override
  State<InstanceScreen> createState() => _InstanceScreenState();
}

class _InstanceScreenState extends State<InstanceScreen> {
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
        // leading: IconButton(
        //   icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
        //       height: 24, fit: BoxFit.scaleDown),
        //   onPressed: () {},
        // ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: MaterialButton(
                    minWidth: 171.w,
                    height: 30.h,
                    elevation: 0,
                    color: Color(0xff009EFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InstanceCreateScreen()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/svg/icons/plus-icon.svg',
                            height: 11.h, fit: BoxFit.scaleDown),
                        SizedBox(width: 12.w),
                        Text(
                          "Create Instance",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 2,
                  child: MaterialButton(
                    height: 30.h,
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xffBBBBBB)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {},
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Filter",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color(0xff353333),
                                  fontWeight: FontWeight.w400)),
                        ),
                        SizedBox(width: 30),
                        SvgPicture.asset('assets/svg/icons/filter.svg',
                            height: 15.h, fit: BoxFit.scaleDown),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 21),
                  CustomWidget.InstanceSpecs(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InstanceDetailScreen()));
                  })
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
