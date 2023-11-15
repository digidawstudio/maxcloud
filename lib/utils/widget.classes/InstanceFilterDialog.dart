import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InstanceFilterDialog extends StatefulWidget {
  final Function onFilter;
  const InstanceFilterDialog({
    super.key,
    required this.onFilter,
  });

  @override
  State<InstanceFilterDialog> createState() => _InstanceFilterDialogState();
}

class _InstanceFilterDialogState extends State<InstanceFilterDialog> {
  String sort = "Newest";
  String status = "Running";

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
            Text("Sort",
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
                      sort = "Newest";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          sort == "Newest"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Newest",
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
                      sort = "Oldest";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          sort == "Oldest"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Oldest",
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
                      sort = "Highest Cost";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          sort == "Highest Cost"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Highest Cost",
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
                      sort = "Lowest Cost";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          sort == "Lowest Cost"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Lowest Cost",
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
                      status = "Running";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Running"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Running",
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
                      status = "Stopped";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Stopped"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Stopped",
                          style: GoogleFonts.manrope(
                              textStyle: const TextStyle(
                                  color: Color(0xffE32115),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500))),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      status = "Pending";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Pending"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Pending",
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
                      status = "Error";
                    });
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          status == "Error"
                              ? 'assets/svg/icons/checkbox-black.svg'
                              : 'assets/svg/icons/uncheck-box.svg',
                          height: 11,
                          fit: BoxFit.scaleDown),
                      SizedBox(width: 8),
                      Text("Error",
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
              onPressed: () {
                widget.onFilter(sort, status);
              },
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
