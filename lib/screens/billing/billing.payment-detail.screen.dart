import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxcloud/bloc/profile/profile.bloc.dart';
import 'package:maxcloud/repository/billing/deposit-history.model.dart';

class BillingPaymentDetailScreen extends StatefulWidget {
  DepositData? depositData;
  BillingPaymentDetailScreen({super.key, required this.depositData});

  @override
  State<BillingPaymentDetailScreen> createState() =>
      _BillingPaymentDetailScreenState();
}

class _BillingPaymentDetailScreenState
    extends State<BillingPaymentDetailScreen> {
  final storage = new FlutterSecureStorage();

  String token = "";
  String username = "";

  @override
  void initState() {
    getAccessToken();
    super.initState();
  }

  void getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    setState(() {
      token = accessToken!;
    });
  }

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
            Text("Detail Payment",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.depositData?.status == 'SUCCESS'
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: SvgPicture.asset(
                                        'assets/svg/icons/checklist-circle-green.svg',
                                        height: 19,
                                        fit: BoxFit.scaleDown),
                                  )
                                : SizedBox.shrink(),
                            Text(widget.depositData?.status ?? "-",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: widget.depositData?.status ==
                                                'EXPIRED'
                                            ? Color.fromARGB(255, 204, 78, 46)
                                            : widget.depositData?.status ==
                                                    'SUCCESS'
                                                ? Color(0xff2ECC71)
                                                : Color.fromARGB(
                                                    255, 234, 219, 62),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700))),
                          ],
                        ),
                        SizedBox(height: 6),
                        Text(widget.depositData?.createdAt ?? "-",
                            style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                    color: Color(0xff232226),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.depositData?.method ?? "-",
                            style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                    color: Color(0xff232226),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Divider(
                  thickness: 1,
                  color: Color(0xffCCCCCC),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(widget.depositData?.description ?? "-",
                      style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                              color: Color(0xff009EFF),
                              fontSize: 15,
                              fontWeight: FontWeight.w700))),
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("ID Transaksi",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                    Text(widget.depositData?.invoiceNumber ?? "-",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Tanggal",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                    Text(widget.depositData?.createdAt ?? "-",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Expired",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                    Text(widget.depositData?.expiredAt ?? "-",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Harga",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                    Text(
                        NumberFormat.currency(
                          locale: 'id',
                          symbol: "Rp ",
                          decimalDigits: 0,
                        ).format(widget.depositData?.amount ?? 0),
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 13,
                                fontWeight: FontWeight.w400))),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: double.infinity,
                color: Color(0xff02D430),
                height: 41,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Pembayaran",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700))),
                      Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: "Rp ",
                            decimalDigits: 0,
                          ).format(widget.depositData?.amount ?? 0),
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
