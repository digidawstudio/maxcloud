import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxcloud/bloc/billing/deposit-detail.bloc.dart';
import 'package:maxcloud/bloc/profile/profile.bloc.dart';
import 'package:maxcloud/repository/billing/deposit-history.model.dart';
import 'package:url_launcher/url_launcher.dart';

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
  DepositDetailBloc? depositDetailBloc;

  String token = "";
  String username = "";

  @override
  void initState() {
    depositDetailBloc = BlocProvider.of<DepositDetailBloc>(context);

    getAccessToken();
    super.initState();
  }

  void getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    depositDetailBloc?.add(FetchDepositDetailEvent(
        accessToken!, widget.depositData!.id.toString()));

    setState(() {
      token = accessToken!;
    });
  }

  onPressPay(String paymentUrl) async {
    final Uri url = Uri.parse(paymentUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
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
        child: RefreshIndicator(
          onRefresh: (() async => getAccessToken()),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: BlocBuilder<DepositDetailBloc, DepositDetailState>(
                builder: (context, state) {
              LoadedDepositDetailState? depositDetail;

              if (state is LoadedDepositDetailState) {
                depositDetail = state;
              }

              return Column(
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
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
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
                                                ? Color.fromARGB(
                                                    255, 204, 78, 46)
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 12),
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
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  (widget.depositData?.status == 'PENDING' &&
                          depositDetail?.data.data?.paymentUrl != '')
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 45,
                            elevation: 0,
                            color: const Color(0xff009EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            onPressed: () {
                              onPressPay(
                                  depositDetail?.data.data?.paymentUrl ?? "");
                            },
                            child: Text(
                              "Pay now",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              );
            }),
          ),
        ),
      )),
    );
  }
}
