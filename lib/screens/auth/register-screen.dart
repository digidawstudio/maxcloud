import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/repository/auth/login.model.dart';
import 'package:maxcloud/screens/auth/login-screen.dart';
import 'package:maxcloud/utils/widgets.dart';

import '../../bloc/auth/auth.bloc.dart';
import 'otp-scren.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthBloc? authBloc;

  TextEditingController credentialController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  bool tosAgreement = true;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
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
              Text("Daftar",
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Color(0xff353333),
                          fontSize: 30,
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
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: ((context, state) {
            if (state is RegisterSuccessState) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              });
            }

            return SafeArea(
                child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        SizedBox(height: 47),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text("Nama",
                        //         style: GoogleFonts.manrope(
                        //             textStyle: TextStyle(
                        //                 color: Color(0xff232226),
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w500))),
                        //     SizedBox(height: 10),
                        //     TextField(
                        //         autocorrect: false,
                        //         // controller: _phoneController,
                        //         style: GoogleFonts.manrope(
                        //             textStyle: TextStyle(
                        //                 fontSize: 14, fontWeight: FontWeight.w400)),
                        //         decoration: InputDecoration(
                        //           contentPadding: EdgeInsets.symmetric(
                        //               vertical: 10.5, horizontal: 15),
                        //           isDense: true,
                        //           hintText: 'Masukkan nama anda',
                        //           hintStyle: GoogleFonts.manrope(
                        //               textStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   color: Color(0xffBBBBBB),
                        //                   fontWeight: FontWeight.w400)),
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //                 width: 1, color: Color(0xffBBBBBB)),
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //           // Set border for focused state
                        //           focusedBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //                 width: 1, color: Color(0xff009EFF)),
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        //         onEditingComplete: () {}),
                        //   ],
                        // ),
                        // SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff232226),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                            SizedBox(height: 10),
                            TextField(
                                autocorrect: false,
                                controller: credentialController,
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.5, horizontal: 15),
                                  isDense: true,
                                  hintText: 'Masukkan email anda',
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
                        // SizedBox(height: 15),
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Text("No. Handphone",
                        //         style: GoogleFonts.manrope(
                        //             textStyle: TextStyle(
                        //                 color: Color(0xff232226),
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w500))),
                        //     SizedBox(height: 10),
                        //     TextField(
                        //         autocorrect: false,
                        //         // controller: _phoneController,
                        //         style: GoogleFonts.manrope(
                        //             textStyle: TextStyle(
                        //                 fontSize: 14, fontWeight: FontWeight.w400)),
                        //         decoration: InputDecoration(
                        //           contentPadding: EdgeInsets.symmetric(
                        //               vertical: 10.5, horizontal: 15),
                        //           isDense: true,
                        //           hintText: '812 - 4021 - 5218',
                        //           hintStyle: GoogleFonts.manrope(
                        //               textStyle: TextStyle(
                        //                   fontSize: 14,
                        //                   color: Color(0xffBBBBBB),
                        //                   fontWeight: FontWeight.w400)),
                        //           enabledBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //                 width: 1, color: Color(0xffBBBBBB)),
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //           // Set border for focused state
                        //           focusedBorder: OutlineInputBorder(
                        //             borderSide: const BorderSide(
                        //                 width: 1, color: Color(0xff009EFF)),
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        //         onEditingComplete: () {}),
                        //   ],
                        // ),
                        SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Masukkan Password",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff232226),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                            SizedBox(height: 10),
                            TextField(
                                autocorrect: false,
                                controller: passwordController,
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.5, horizontal: 15),
                                  isDense: true,
                                  suffixIcon: SvgPicture.asset(
                                      'assets/svg/icons/password-not-visible.svg',
                                      height: 16,
                                      fit: BoxFit.scaleDown),
                                  hintText: 'Masukkan password anda',
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
                        SizedBox(height: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Konfirmasi ulang Password",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff232226),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500))),
                            SizedBox(height: 10),
                            TextField(
                                autocorrect: false,
                                controller: rePasswordController,
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.5, horizontal: 15),
                                  isDense: true,
                                  suffixIcon: SvgPicture.asset(
                                      'assets/svg/icons/password-not-visible.svg',
                                      height: 16,
                                      fit: BoxFit.scaleDown),
                                  hintText: 'Masukkan ulang password anda',
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
                        SizedBox(height: 40),
                        Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svg/icons/checkbox.svg',
                                  height: 18, fit: BoxFit.scaleDown),
                              SizedBox(width: 10),
                              Text("Saya setuju dengan peraturan yang ada.",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xffBBBBBB),
                                          fontWeight: FontWeight.w500))),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
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
                              authBloc?.add(RegisterEvent(
                                  credentialController.text,
                                  passwordController.text,
                                  tosAgreement));
                            },
                            child: Text(
                              "Daftar",
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
                  ),
                ),
                state is LoadingAuthState ? CustomWidget.loader() : Container()
              ],
            ));
          }),
        ));
  }
}
