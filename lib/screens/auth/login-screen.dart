import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/bloc/auth/auth.bloc.dart';
import 'package:maxcloud/screens/auth/otp-scren.dart';
import 'package:maxcloud/screens/auth/register-screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Login",
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Color(0xff353333),
                          fontSize: 30,
                          fontWeight: FontWeight.w600))),
              SizedBox(height: 44),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Masukkan Email",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Color(0xff232226),
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      // controller: _phoneController,
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
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
                      // controller: _phoneController,
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
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
                    // authBloc.add(LoginEvent());
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OtpScreen()));
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) => MaterialButton(
                    minWidth: double.infinity,
                    height: 45,
                    elevation: 0,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(width: 1, color: Color(0xffBBBBBB))),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => OtpScreen()));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          width: 28,
                          height: 28,
                          image:
                              AssetImage("assets/images/icons/google-icon.png"),
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Login with google",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffBBBBBB),
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 53),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Belum punya akun? ',
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xffC3C7CF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500)),
                    children: [
                      TextSpan(
                        text: 'Daftar Sekarang',
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
      )),
    );
  }
}
