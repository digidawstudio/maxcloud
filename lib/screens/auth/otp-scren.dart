import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/bloc/auth/auth.bloc.dart';
import 'package:maxcloud/repository/auth/login.model.dart';
import 'package:maxcloud/screens/auth/pin-screen.dart';
import 'package:maxcloud/screens/navbar.component.dart';
import 'package:maxcloud/utils/widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final LoginModel? loginData;
  const OtpScreen({super.key, this.loginData});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  AuthBloc? authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc?.add(RequestOtpEvent(widget.loginData?.data?.email ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if(state is OtpReceivedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) => Flushbar(message: "Otp Sent!", flushbarPosition: FlushbarPosition.TOP, backgroundColor: Colors.greenAccent, messageColor: Colors.white,).show(context));
          
        } else if(state is ErrorAuthState) {
          WidgetsBinding.instance.addPostFrameCallback((_) => Flushbar(message: state.error.message, backgroundColor: Colors.red, messageColor: Colors.white,));
        } else if(state is OtpValidatedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => NavbarComponent()));
          });
        }

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
                Text("Kode OTP",
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
          body: Stack(
            children: [
              SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Masukkan Kode Verifikasi OTP",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff353333),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600))),
                      const SizedBox(height: 24),
                      Text(
                          "Kode Verifikasi telah dikirim melalui nomor telepon +62899",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xffBBBBBB),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400))),
                      SizedBox(height: 44),
                      // OtpTextField(
                      //   numberOfFields: 6,
                      //   fieldWidth: 45,
                      //   borderColor: Color(0xffBBBBBB),
                      //   focusedBorderColor: Color(0xff009EFF),
                      //   showFieldAsBox: true,
                      //   textStyle: GoogleFonts.manrope(
                      //       textStyle: TextStyle(
                      //           color: Color(0xff009EFF),
                      //           fontSize: 30,
                      //           fontWeight: FontWeight.w500)),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 10,
                        ),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          animationType: AnimationType.fade,
                          textStyle: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff009EFF),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500)),
                          pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              borderWidth: 1,
                              fieldHeight: 60,
                              fieldWidth: 45,
                              activeFillColor: Colors.white,
                              inactiveColor: Color(0xffBBBBBB),
                              activeColor: Color(0xff009EFF),
                              selectedColor: Color(0xff009EFF)),
                          cursorColor: Color(0xff009EFF),
                          animationDuration: const Duration(milliseconds: 300),
                          keyboardType: TextInputType.number,

                          onCompleted: (v) {
                            debugPrint("Completed");
                            authBloc?.add(ValidateOtpEvent(widget.loginData?.data?.email ?? "", v));
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => PinScreen()));
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          // onChanged: (value) {
                          //   debugPrint(value);
                          //   setState(() {
                          //     currentText = value;
                          //   });
                          // },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                      ),
                      SizedBox(height: 52),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Tidak menerima kode verifikasi? ',
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    color: Color(0xffBBBBBB),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                            children: [
                              TextSpan(
                                text: 'Kirim Ulang',
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff009EFF),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              state is LoadingAuthState ? CustomWidget.loader() : Container()
            ],
          ),
        );
      },
    );
  }
}
