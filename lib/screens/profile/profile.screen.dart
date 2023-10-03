import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey.shade100,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Profile",
              style: GoogleFonts.manrope(
                textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        // leading: IconButton(
        //   icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
        //       height: 24, fit: BoxFit.scaleDown),
        //   onPressed: () {},
        // ),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/elon.jpg',
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),
              ),
              SizedBox(height: 10),
              Text("Didan Alzabar",
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Color(0xff232226),
                          fontSize: 24,
                          fontWeight: FontWeight.w600))),
              SizedBox(height: 4),
              Text("0878 - 9248 - 9244",
                  style: GoogleFonts.manrope(
                      textStyle: TextStyle(
                          color: Color(0xffBBBBBB),
                          fontSize: 13,
                          fontWeight: FontWeight.w500))),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/icons/edit-profile.svg',
                          height: 28, fit: BoxFit.scaleDown),
                      SizedBox(width: 10),
                      Text("Edit Profile",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)))
                    ]),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
                color: Color(0xffBBBBBB),
              ),
              SizedBox(height: 5),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Full Name",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'Full Name',
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
                          Text("Phone Number",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'Phone Number',
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
                          Text("Address",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'Address',
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
                          Text("Country",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'Country',
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
                          Text("Select Province",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'Province',
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
                          Text("Select City",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'City',
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
                          Text("Select District",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'District',
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
                          onPressed: () {},
                          child: Text(
                            "Update",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/icons/change-password.svg',
                          height: 28, fit: BoxFit.scaleDown),
                      SizedBox(width: 10),
                      Text("Change Password",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)))
                    ]),
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
                color: Color(0xffBBBBBB),
              ),
              SizedBox(height: 5),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Password",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'Masukkan password lama anda',
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
                          Text("New Password",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText: 'Masukkan password baru anda',
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
                          Text("Password Confirmation",
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.5, horizontal: 15),
                                isDense: true,
                                hintText:
                                    'Masukkan konfirmasi password baru anda',
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
                          onPressed: () {},
                          child: Text(
                            "Update",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 40),
            ],
          ),
        ),
      )),
    );
  }
}
