import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/screens/navbar.component.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
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
            Text("PIN",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
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
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 42),
            Text("Masukkan PIN",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff353333),
                        fontSize: 20,
                        fontWeight: FontWeight.w600))),
            const SizedBox(height: 24),
            Text("Masukkan PIN yang mudah diingat bagi anda",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xffBBBBBB),
                        fontSize: 12,
                        fontWeight: FontWeight.w400))),
            const SizedBox(height: 44),
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
                    textStyle: const TextStyle(
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
                    inactiveColor: const Color(0xffBBBBBB),
                    activeColor: const Color(0xff009EFF),
                    selectedColor: const Color(0xff009EFF)),
                cursorColor: const Color(0xff009EFF),
                animationDuration: const Duration(milliseconds: 300),
                keyboardType: TextInputType.number,

                onCompleted: (v) {
                  debugPrint("Completed");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NavbarComponent()));
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
          ],
        ),
      )),
    );
  }
}
