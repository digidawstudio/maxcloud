import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxcloud/bloc/billing/create-invoice.bloc.dart';
import 'package:maxcloud/bloc/billing/payment-method.bloc.dart';
import 'package:maxcloud/bloc/profile/profile.bloc.dart';
import 'package:maxcloud/screens/billing/history.screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../repository/billing/payment-method.model.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BillingPaymentScreen extends StatefulWidget {
  final String paymentMethod;
  final int nominal;
  const BillingPaymentScreen(
      {super.key, required this.paymentMethod, required this.nominal});

  @override
  State<BillingPaymentScreen> createState() => _BillingPaymentScreenState();
}

class _BillingPaymentScreenState extends State<BillingPaymentScreen> {
  CreateInvoiceBloc? createInvoiceBloc;

  String selectedMethod = "Select Payment Method";
  String selectedSubMethod = "Select Payment Method";
  String selectedSubMethodCode = "";
  int adminFee = 0;
  String? phoneNumb = "";

  final storage = new FlutterSecureStorage();

  String token = "";

  @override
  void initState() {
    createInvoiceBloc = BlocProvider.of<CreateInvoiceBloc>(context);

    setState(() {
      selectedMethod = widget.paymentMethod;
    });

    createInvoiceBloc?.add(InitialCreateInvoiceEvent());

    final LoadedProfileState profileState =
        BlocProvider.of<ProfileBloc>(context).state as LoadedProfileState;

    setState(() {
      phoneNumb = profileState.data.data?.phone!;
    });

    getAccessToken();
    super.initState();
  }

  void getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    setState(() {
      token = accessToken!;
    });
  }

  onLaunchPaymentLink(String paymentUrl) async {
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
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
              height: 24, fit: BoxFit.scaleDown),
          onPressed: () {
            createInvoiceBloc?.add(InitialCreateInvoiceEvent());
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Choose Payment Method",
                    style: GoogleFonts.manrope(
                        textStyle: const TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w500))),
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
                  if (state is LoadingPaymentMethodState) {
                    return Center(
                      child: LoadingAnimationWidget.waveDots(
                        color: Color.fromARGB(255, 168, 168, 168),
                        size: 30,
                      ),
                    );
                  }
                  if (state is LoadedPaymentMethodState) {
                    final List<DropdownMenuItem> list = [
                      const DropdownMenuItem(
                          value: "Select Payment Method",
                          child: Text("Select Payment Method")),
                    ];

                    state.data.forEach((key, value) {
                      list.add(DropdownMenuItem(
                          value: key,
                          child: Text(toBeginningOfSentenceCase(key) ?? "")));
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
                                  textStyle: TextStyle(
                                      color: Color(0xff232226),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedMethod = newValue!;
                                  selectedSubMethod = "Select Payment Method";
                                });
                              },
                              items: list,
                            )));
                  }
                  return Container();
                }),
              ),
              const SizedBox(height: 8),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(height: 8),
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
                  if (state is LoadingPaymentMethodState) {
                    return Center(
                      child: LoadingAnimationWidget.waveDots(
                        color: Color.fromARGB(255, 168, 168, 168),
                        size: 30,
                      ),
                    );
                  }

                  if (state is LoadedPaymentMethodState) {
                    List<dynamic> loadedSubMethod = state.data[
                        selectedMethod != "Select Payment Method"
                            ? selectedMethod
                            : widget.paymentMethod];

                    final List<DropdownMenuItem> list = [
                      const DropdownMenuItem(
                          value: "Select Payment Method",
                          child: Text("Select Payment Method")),
                    ];

                    loadedSubMethod.forEach((e) {
                      list.add(DropdownMenuItem(
                          value: e['name'],
                          child: Row(
                            children: [
                              Image.network(
                                e['image'],
                                height: 22,
                              ),
                              SizedBox(width: 10),
                              Text(toBeginningOfSentenceCase(e['name']) ?? ""),
                            ],
                          )));
                    });

                    return DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              value: selectedSubMethod,
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
                                      fontWeight: FontWeight.w600)),
                              onChanged: (newValue) {
                                var selected = loadedSubMethod
                                    .where((i) => i['name'] == newValue)
                                    .toList();

                                setState(() {
                                  selectedSubMethod = newValue!;
                                  adminFee = selected[0]['fee'];
                                  selectedSubMethodCode = selected[0]['code'];
                                });
                              },
                              items: list,
                            )));
                  }

                  return Container();
                }),
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
                              textStyle: const TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500)),
                          children: [
                        TextSpan(
                            text: NumberFormat.currency(
                              locale: 'id',
                              symbol: "Rp ",
                              decimalDigits: 0,
                            ).format(adminFee ?? 0),
                            style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                    color: Color(0xff232226),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500)))
                      ]))
                ],
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<CreateInvoiceBloc, CreateInvoiceState>(
                    builder: (context, state) {
                  return MaterialButton(
                    minWidth: double.infinity,
                    height: 45,
                    elevation: 0,
                    color: Color(0xff009EFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    onPressed: state is LoadingCreateInvoiceState
                        ? () {}
                        : () async {
                            BlocProvider.of<CreateInvoiceBloc>(context)
                                .add(PostCreateInvoiceEvent(token, {
                              "amount": widget.nominal,
                              "phone": phoneNumb,
                              "payment_method": selectedSubMethodCode
                            }));
                          },
                    child: state is LoadingCreateInvoiceState
                        ? Center(
                            child: LoadingAnimationWidget.waveDots(
                              color: Colors.white,
                              size: 30,
                            ),
                          )
                        : Text(
                            "Confirm Payment",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                  );
                }),
              ),
              SizedBox(height: 30.h),
              BlocBuilder<CreateInvoiceBloc, CreateInvoiceState>(
                  builder: (context, state) {
                if (state is LoadedCreateInvoiceState &&
                    state.data.data?.vaNumber != null) {
                  return AbsorbPointer(
                    absorbing: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Number",
                            style: GoogleFonts.manrope(
                                textStyle: const TextStyle(
                                    color: Color(0xff232226),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500))),
                        SizedBox(height: 10),
                        TextField(
                            enabled: true,
                            readOnly: true,
                            autocorrect: false,
                            controller: TextEditingController(
                                text: state.data.data?.vaNumber ?? ""),
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
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(height: 16),
              BlocBuilder<CreateInvoiceBloc, CreateInvoiceState>(
                  builder: (context, state) {
                if (state is LoadedCreateInvoiceState) {
                  if (state.data.data?.paymentUrl != '') {
                    onLaunchPaymentLink(state.data.data?.paymentUrl ?? "");
                  }

                  return AbsorbPointer(
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
                            // Text("Details",
                            //     style: GoogleFonts.manrope(
                            //         textStyle: TextStyle(
                            //             decoration: TextDecoration.underline,
                            //             color: Color(0xff009EFF),
                            //             fontSize: 14,
                            //             fontWeight: FontWeight.w500))),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextField(
                            autocorrect: false,
                            enabled: true,
                            readOnly: true,
                            controller: TextEditingController(
                                text: NumberFormat.currency(
                              locale: 'id',
                              symbol: "Rp ",
                              decimalDigits: 0,
                            ).format(state.data.data?.amount ?? 0).toString()),
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
                  );
                } else {
                  return Container();
                }
              }),
              SizedBox(height: 25),
              BlocBuilder<CreateInvoiceBloc, CreateInvoiceState>(
                  builder: (context, state) {
                if (state is LoadedCreateInvoiceState &&
                    state.data.data?.qrString != null) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: QrImageView(
                      data: state.data.data?.qrString ?? "",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  );
                } else {
                  return Container();
                }
              }),
              BlocBuilder<CreateInvoiceBloc, CreateInvoiceState>(
                  builder: (context, state) {
                if (state is LoadedCreateInvoiceState) {
                  return Container(
                    width: 200.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: const Color(0xff02D430),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text("Transaction Success!",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600))),
                    ),
                  );
                } else {
                  return Container();
                }
              })
            ],
          ),
        ),
      )),
    );
  }
}
