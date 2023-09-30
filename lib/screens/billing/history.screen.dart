import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Payment History"),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 26.w, right: 26.w, top: 26.h),
              child: ButtonTheme(
                minWidth: 171.w,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Tanggal ajah disini",
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff009Eff)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r))),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 19.h,
            ),
            Flexible(
              child: Container(
                height: ScreenUtil().screenHeight,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 26.w, right: 26.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 212.h,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15.w, vertical: 28.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffbbbbbb)),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Balance",
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.black),
                                  children: [
                                    TextSpan(text: "Rp "),
                                    TextSpan(
                                        text: "0,00",
                                        style: TextStyle(
                                            color: Color(0xff009EFF),
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Charge This Month",
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Color(0xff232226)),
                                  children: [
                                    TextSpan(text: "Rp "),
                                    TextSpan(
                                        text: "1.000.000,00",
                                        style: TextStyle(
                                            color: Color(0xff009EFF),
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                            Expanded(child: Container()),
                            Text(
                              "Estimated Balance",
                              style: TextStyle(fontSize: 10.sp),
                            ),
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 20.sp, color: Colors.black),
                                  children: [
                                    TextSpan(text: "Rp "),
                                    TextSpan(
                                        text: "100.000.000,00",
                                        style: TextStyle(
                                            color: Color(0xff009EFF),
                                            fontWeight: FontWeight.bold)),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 45.h,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(100, (_) => []).map((e) => items()).toList(),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget items() {
    return Container(
      height: 65.h,
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 2,
            color: Colors.black26
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Top Up", style: TextStyle(fontSize: 12.sp, color: Color(0xff009EFF)),),
              SizedBox(height: 5.h,),
              Text("BCA 123456", style: TextStyle(fontSize: 12.sp, color: Color(0xffbbbbbb)),),
            ],
          ),
          Expanded(child: Container()),
          Text("-Rp 50.000")
        ],
      ),
    );
  }
}
