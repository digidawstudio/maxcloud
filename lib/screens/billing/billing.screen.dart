import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/screens/instance/instance.create.screen.dart';
import 'package:maxcloud/screens/instance/instance.detail.screen.dart';
import 'package:maxcloud/utils/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
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
        // leading: IconButton(
        //   icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
        //       height: 24, fit: BoxFit.scaleDown),
        //   onPressed: () {},
        // ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Pilih Jumlah Pembayaran",
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Color(0xff232226),
                          fontSize: 18,
                          fontWeight: FontWeight.w500))),
            ),
            SizedBox(height: 18.h),
            TextField(
                autocorrect: false,
                // controller: _phoneController,
                style: GoogleFonts.manrope(
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.5, horizontal: 15),
                  isDense: true,
                  hintText: 'Masukkan jumlah',
                  hintStyle: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: Color(0xffBBBBBB),
                          fontWeight: FontWeight.w400)),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xffBBBBBB)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // Set border for focused state
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 1, color: Color(0xff009EFF)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onEditingComplete: () {}),
            SizedBox(height: 30),
            billingList(),
            SizedBox(height: 30),
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
                onPressed: () {
                  choosePaymentMethodModal(context);
                },
                child: Text(
                  "Confirm",
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget billingList() {
    return Column(children: [
      Row(
        children: [billingItem(), SizedBox(width: 8), billingItem()],
      ),
      SizedBox(height: 20),
      Row(
        children: [billingItem(), SizedBox(width: 8), billingItem()],
      ),
      SizedBox(height: 20),
      Row(
        children: [billingItem(), SizedBox(width: 8), billingItem()],
      ),
    ]);
  }

  Widget billingItem() {
    return Flexible(
      flex: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xffbbbbbb),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xffbbbbbb),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8)),
            ),
            SizedBox(width: 11),
            Text("Rp 100.000",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff232226),
                        fontSize: 15,
                        fontWeight: FontWeight.w600)))
          ],
        ),
      ),
    );
  }

  choosePaymentMethodModal(BuildContext contexte) {
    return showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: Container(
              width: double.infinity,
              height: ScreenUtil().screenHeight / 2.5,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 26, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Choose Payment Method",
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                color: Color(0xff232226),
                                fontSize: 18,
                                fontWeight: FontWeight.w600))),
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
                              value: "E-Wallet",
                              icon: SvgPicture.asset(
                                  'assets/svg/icons/dropdown.svg',
                                  height: 15.h,
                                  fit: BoxFit.scaleDown),
                              iconSize: 24,
                              elevation: 0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff232226),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              onChanged: (String? newValue) {
                                setState(() {
                                  // dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'E-Wallet',
                                'Virtual Account',
                                'QRIS'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ))),
                  ),
                  SizedBox(height: 50),
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
                        "Confirm",
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          );
        });
  }
}
