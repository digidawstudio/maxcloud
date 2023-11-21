import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmationDialog extends StatefulWidget {
  final Function onPressCancel, onPressOk;
  final String wording;
  const ConfirmationDialog(
      {super.key,
      required this.onPressCancel,
      required this.onPressOk,
      required this.wording});

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 41, vertical: 25),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/warning.png",
              height: 60,
            ),
            SizedBox(height: 20),
            Text(
              widget.wording,
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      fontSize: 14,
                      color: const Color(0xff232226),
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      widget.onPressCancel();
                    },
                    child: ToggleButton("Cancel")),
                Expanded(child: Container()),
                GestureDetector(
                    onTap: () {
                      widget.onPressOk();
                    },
                    child: ToggleButton("OK")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ToggleButton(String type) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: type == "OK" ? const Color(0xff009EFF) : Colors.red,
      child: SizedBox(
        height: 39,
        width: 110,
        child: Center(
            child: Text(
          type,
          style: GoogleFonts.manrope(
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
        )),
      ),
    );
  }
}
