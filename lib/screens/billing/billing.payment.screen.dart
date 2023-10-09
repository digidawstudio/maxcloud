import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/screens/billing/history.screen.dart';
import 'package:maxcloud/screens/instance/instance.create.screen.dart';
import 'package:maxcloud/screens/instance/instance.detail.screen.dart';
import 'package:maxcloud/utils/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class BillingPaymentScreen extends StatefulWidget {
  const BillingPaymentScreen({super.key});

  @override
  State<BillingPaymentScreen> createState() => _BillingPaymentScreenState();
}

class _BillingPaymentScreenState extends State<BillingPaymentScreen> {
  String dropdownValue = 'E-Wallet';

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
            Text("Billing",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()));
            },
            child: SvgPicture.asset('assets/svg/icons/billing-history.svg',
                height: 33.h, fit: BoxFit.scaleDown),
          ),
          SizedBox(width: 25)
        ],
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
              height: 24, fit: BoxFit.scaleDown),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Choose Payment Method",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))),
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Color(
                        0xFFBBBBBB), // Ubah warna border sesuai kebutuhan Anda
                  ),
                ),
                child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: SvgPicture.asset(
                              'assets/svg/icons/dropdown.svg',
                              height: 15.h,
                              fit: BoxFit.scaleDown),
                          iconSize: 24,
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: <String>['E-Wallet', 'Virtual Account', 'QRIS']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ))),
              ),
              SizedBox(height: 8),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
                    color: Color(
                        0xFFBBBBBB), // Ubah warna border sesuai kebutuhan Anda
                  ),
                ),
                child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          value: "OVO",
                          icon: SvgPicture.asset(
                              'assets/svg/icons/dropdown.svg',
                              height: 15.h,
                              fit: BoxFit.scaleDown),
                          iconSize: 24,
                          elevation: 0,
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          onChanged: (String? newValue) {
                            setState(() {
                              // dropdownValue = newValue!;
                            });
                          },
                          items: <String>['OVO', 'Gopay', 'Shopee Pay']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row(children: [
                                Image.asset(
                                  "assets/images/icons/ovo-logo.png",
                                  height: 15.h,
                                ),
                                SizedBox(width: 15.w),
                                Text(value)
                              ]),
                            );
                          }).toList(),
                        ))),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/info-circle.svg',
                      height: 16.h, fit: BoxFit.scaleDown),
                  SizedBox(width: 6.w),
                  RichText(
                      text: TextSpan(
                          text: "Admin fee ",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)),
                          children: [
                        TextSpan(
                            text: "Rp 2.500",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    color: Color(0xff232226),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)))
                      ]))
                ],
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 45,
                  elevation: 0,
                  color: Color(0xff009EFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Confirm Payment",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              AbsorbPointer(
                absorbing: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Number",
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                color: Color(0xff232226),
                                fontSize: 14,
                                fontWeight: FontWeight.w500))),
                    SizedBox(height: 10),
                    TextField(
                        autocorrect: false,
                        // controller: _phoneController,
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.5, horizontal: 15),
                          isDense: true,
                          suffixIcon: SvgPicture.asset(
                              'assets/svg/icons/copy.svg',
                              height: 16,
                              fit: BoxFit.scaleDown),
                          hintText: '-',
                          hintStyle: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffBBBBBB),
                                  fontWeight: FontWeight.w400)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffBBBBBB)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // Set border for focused state
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xff009EFF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onEditingComplete: () {}),
                  ],
                ),
              ),
              SizedBox(height: 16),
              AbsorbPointer(
                absorbing: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Amount",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    color: Color(0xff232226),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                        Text("Details",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color(0xff009EFF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextField(
                        autocorrect: false,
                        // controller: _phoneController,
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.5, horizontal: 15),
                          isDense: true,
                          suffixIcon: SvgPicture.asset(
                              'assets/svg/icons/copy.svg',
                              height: 16,
                              fit: BoxFit.scaleDown),
                          hintText: 'Rp -',
                          hintStyle: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffBBBBBB),
                                  fontWeight: FontWeight.w400)),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xffBBBBBB)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // Set border for focused state
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xff009EFF)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onEditingComplete: () {}),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: 200.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Color(0xff02D430),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text("Transaction Success!",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600))),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
