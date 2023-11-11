import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxcloud/bloc/billing/payment-method.bloc.dart';
import 'package:maxcloud/screens/billing/billing.payment.screen.dart';
import 'package:maxcloud/screens/billing/history.screen.dart';

import '../../bloc/profile/profile.bloc.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  PaymentMethodBloc? paymentMethodBloc;
  final storage = const FlutterSecureStorage();

  String token = "";
  int selectedNominal = 100000;
  String selectedMethod = "Select Payment Method";

  @override
  void initState() {
    paymentMethodBloc = BlocProvider.of<PaymentMethodBloc>(context);

    getAccessToken();
    super.initState();
  }

  void getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    paymentMethodBloc
        ?.add(FetchPaymentMethodEvent(accessToken ?? "", selectedNominal));

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
            Text("Billing",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HistoryScreen()));
            },
            child: SvgPicture.asset('assets/svg/icons/billing-history.svg',
                height: 33.h, fit: BoxFit.scaleDown),
          ),
          const SizedBox(width: 25)
        ],
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text("Pilih Jumlah Pembayaran",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Color(0xff232226),
                          fontSize: 18,
                          fontWeight: FontWeight.w600))),
            ),
            SizedBox(height: 18.h),
            TextField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                // controller: _phoneController,
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.5, horizontal: 15),
                  isDense: true,
                  hintText: 'Masukkan jumlah',
                  hintStyle: GoogleFonts.manrope(
                      textStyle: const TextStyle(
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
            const SizedBox(height: 30),
            billingList(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 45,
                elevation: 0,
                color: const Color(0xff009EFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: () {
                  paymentMethodBloc
                      ?.add(FetchPaymentMethodEvent(token, selectedNominal));
                  choosePaymentMethodModal(context, selectedMethod);
                },
                child: Text(
                  "Confirm",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
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
        children: [
          billingItem(100000),
          const SizedBox(width: 8),
          billingItem(200000)
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          billingItem(500000),
          const SizedBox(width: 8),
          billingItem(750000)
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          billingItem(1000000),
          const SizedBox(width: 8),
          billingItem(2000000)
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          billingItem(5000000),
          const SizedBox(width: 8),
          billingItem(10000000)
        ],
      ),
    ]);
  }

  Widget billingItem(int nominal) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () => setState(() {
          selectedNominal = nominal;
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: selectedNominal == nominal
                    ? const Color(0Xff009EFF)
                    : const Color(0xffbbbbbb),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              selectedNominal != nominal
                  ? Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffbbbbbb),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8)),
                    )
                  : Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                          color: const Color(0Xff009EFF),
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                          child: SvgPicture.asset(
                              'assets/svg/icons/checklist-white.svg',
                              height: 16.h,
                              fit: BoxFit.scaleDown)),
                    ),
              const SizedBox(width: 11),
              Text(
                  "Rp ${NumberFormat.currency(
                    locale: 'id',
                    symbol: "",
                    decimalDigits: 0,
                  ).format(nominal ?? 0)}",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Color(0xff232226),
                          fontSize: 14,
                          fontWeight: FontWeight.w600)))
            ],
          ),
        ),
      ),
    );
  }

  choosePaymentMethodModal(BuildContext context, String selectedMethod) {
    return showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext subcontext, StateSetter subsetState) {
            return ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Container(
                width: double.infinity,
                height: ScreenUtil().screenHeight / 2.5,
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Choose Payment Method",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600))),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffF1F1F1),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: const Color(
                              0xFFBBBBBB), // Ubah warna border sesuai kebutuhan Anda
                        ),
                      ),
                      child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
                          builder: (context, state) {
                        if (state is LoadedPaymentMethodState) {
                          final List<DropdownMenuItem> list = [
                            const DropdownMenuItem(
                                value: "Select Payment Method",
                                child: Text("Select Payment Method")),
                          ];

                          state.data.forEach((key, value) {
                            list.add(DropdownMenuItem(
                                value: key,
                                child: Text(
                                    toBeginningOfSentenceCase(key) ?? "")));
                          });

                          return DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    value: selectedMethod,
                                    icon: SvgPicture.asset(
                                        'assets/svg/icons/dropdown.svg',
                                        height: 15.h,
                                        fit: BoxFit.scaleDown),
                                    iconSize: 24,
                                    elevation: 0,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.r)),
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    onChanged: (newValue) {
                                      subsetState(() {
                                        selectedMethod = newValue!;
                                      });
                                    },
                                    items: list,
                                  )));
                        } else {
                          return Center(
                            child: LoadingAnimationWidget.waveDots(
                              color: Color.fromARGB(255, 168, 168, 168),
                              size: 30,
                            ),
                          );
                        }
                      }),
                    ),
                    const SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 45,
                        elevation: 0,
                        color: const Color(0xff009EFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BillingPaymentScreen(
                                        paymentMethod: selectedMethod,
                                        nominal: selectedNominal,
                                      )));
                        },
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            );
          });
        });
  }
}
