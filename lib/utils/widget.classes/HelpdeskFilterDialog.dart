import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpdeskFilterDialog extends StatefulWidget {
  final Function onFilter;
  const HelpdeskFilterDialog({
    super.key,
    required this.onFilter,
  });

  @override
  State<HelpdeskFilterDialog> createState() => _HelpdeskFilterDialogState();
}

class _HelpdeskFilterDialogState extends State<HelpdeskFilterDialog> {
  String department = "Support";
  String status = "Open";

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 41, vertical: 20),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Department",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff009EFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w700))),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      department = "Support";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          department == "Support"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Support",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      department = "Billing";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          department == "Billing"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Billing",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 18),
            Text("Status",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff009EFF),
                        fontSize: 16,
                        fontWeight: FontWeight.w700))),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      status = "Open";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Open"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Open",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xff02D430),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      status = "Answered";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Answered"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Answered",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xffFF9900),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      status = "Customer Reply";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Customer Reply"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Customer Reply",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xff18369E),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      status = "Close";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Close"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Close",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            MaterialButton(
              minWidth: double.infinity,
              height: 26,
              padding: EdgeInsets.all(10),
              elevation: 0,
              color: const Color(0xff009EFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () {},
              child: Text(
                "Filter",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
