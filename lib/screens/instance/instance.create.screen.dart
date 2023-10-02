import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InstanceCreateScreen extends StatefulWidget {
  const InstanceCreateScreen({super.key});

  @override
  State<InstanceCreateScreen> createState() => _InstanceCreateScreenState();
}

class _InstanceCreateScreenState extends State<InstanceCreateScreen> {
  double _currentCPUSliderValue = 0;
  double _currentRAMSliderValue = 0;
  double _currentDISKSliderValue = 0;

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
            Text("Instance",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
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
      bottomNavigationBar: bottomNav(),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Create Virtual Machine",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffbbbbbb),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10.r)),
                child: Row(children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF1F1F1),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                                  'assets/svg/flags/indonesia.svg',
                                  height: 17,
                                  fit: BoxFit.scaleDown)))),
                  VerticalDivider(
                    thickness: 1,
                    width: 0,
                    color: const Color(0xffbbbbbb),
                  ),
                  Expanded(
                      flex: 8,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Indonesia",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          color: Color(0xffBBBBBB),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400))),
                              Text("Jakarta DC1",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          color: Color(0xff232226),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600)))
                            ]),
                      ))
                ]),
              ),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Tier",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffbbbbbb),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                            'assets/svg/icons/chart-icon.svg',
                            height: 18,
                            fit: BoxFit.scaleDown),
                      ),
                      SizedBox(width: 16),
                      Flexible(
                        flex: 9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Optimized Cloud Compute",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff232226),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(height: 5),
                            Text(
                                "Dengan komputasi tingkat tinggi yang akan menciptakan peluang tanpa batas",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        color: Color(0xff959595),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500)))
                          ],
                        ),
                      )
                    ]),
              ),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Operating System",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 15),
              osList(),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Server Size",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 15),
              planList(),
              SizedBox(height: 35),
              Container(
                width: ScreenUtil().screenWidth,
                // height: 219.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border:
                      Border.all(width: 1.0, color: const Color(0xFFBBBBBB)),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: "Rp 140.000,03",
                                    style: GoogleFonts.manrope(
                                        textStyle: TextStyle(
                                            color: Color(0xff009EFF),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    children: [
                                  TextSpan(
                                      text: "/month",
                                      style: GoogleFonts.manrope(
                                          textStyle: TextStyle(
                                              color: Color(0xffBBBBBB),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400)))
                                ])),
                            Container(
                              width: 95.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                color: Color(0xffF1F1F1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                  child: RichText(
                                      text: TextSpan(
                                          text: "Rp 194,44",
                                          style: GoogleFonts.manrope(
                                              textStyle: TextStyle(
                                                  color: Color(0xff232226),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600)),
                                          children: [
                                    TextSpan(
                                        text: "/hour",
                                        style: GoogleFonts.manrope(
                                            textStyle: TextStyle(
                                                color: Color(0xffBBBBBB),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400)))
                                  ]))),
                            )
                          ]),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CPU",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff232226),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                          SizedBox(height: 14),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 8,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Color(0xff232226),
                                      inactiveTrackColor: Color(0xffBBBBBB),
                                      trackShape: RectangularSliderTrackShape(),
                                      trackHeight: 2.0,
                                      thumbColor: Colors.blueAccent,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 8.0),
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 10.0),
                                    ),
                                    child: Slider(
                                      value: _currentCPUSliderValue,
                                      max: 100,
                                      divisions: 5,
                                      label: _currentCPUSliderValue
                                          .round()
                                          .toString(),
                                      onChanged: (double value) {
                                        setState(() {
                                          _currentCPUSliderValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                      width: 40.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xff009EFF),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                            _currentCPUSliderValue
                                                .toInt()
                                                .toString(),
                                            style: GoogleFonts.manrope(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                    ))
                              ]),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("RAM",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff232226),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                          SizedBox(height: 14),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 8,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Color(0xff232226),
                                      inactiveTrackColor: Color(0xffBBBBBB),
                                      trackShape: RectangularSliderTrackShape(),
                                      trackHeight: 2.0,
                                      thumbColor: Colors.blueAccent,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 8.0),
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 10.0),
                                    ),
                                    child: Slider(
                                      value: _currentRAMSliderValue,
                                      max: 100,
                                      divisions: 5,
                                      label: _currentRAMSliderValue
                                          .round()
                                          .toString(),
                                      onChanged: (double value) {
                                        setState(() {
                                          _currentRAMSliderValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                      width: 40.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xff009EFF),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                            _currentRAMSliderValue
                                                .toInt()
                                                .toString(),
                                            style: GoogleFonts.manrope(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                    ))
                              ]),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DISK",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff232226),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))),
                          SizedBox(height: 14),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 8,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: Color(0xff232226),
                                      inactiveTrackColor: Color(0xffBBBBBB),
                                      trackShape: RectangularSliderTrackShape(),
                                      trackHeight: 2.0,
                                      thumbColor: Colors.blueAccent,
                                      thumbShape: RoundSliderThumbShape(
                                          enabledThumbRadius: 8.0),
                                      overlayShape: RoundSliderOverlayShape(
                                          overlayRadius: 10.0),
                                    ),
                                    child: Slider(
                                      value: _currentDISKSliderValue,
                                      max: 100,
                                      divisions: 5,
                                      label: _currentDISKSliderValue
                                          .round()
                                          .toString(),
                                      onChanged: (double value) {
                                        setState(() {
                                          _currentDISKSliderValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                      width: 40.w,
                                      height: 20.h,
                                      decoration: BoxDecoration(
                                        color: Color(0xff009EFF),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                            _currentDISKSliderValue
                                                .toInt()
                                                .toString(),
                                            style: GoogleFonts.manrope(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w400))),
                                      ),
                                    ))
                              ]),
                        ],
                      )
                    ]),
              ),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Detail Information",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hostname",
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
                        hintText: 'Enter your Hostname',
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
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Username",
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
                        hintText: 'Enter your Username',
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
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Kata Sandi",
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
                        hintText: 'Enter your Password',
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
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("SSH Keys",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Color(0xff232226),
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffbbbbbb),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(children: [
                      Container(
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: Color(0xffF1F1F1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                                  'assets/svg/icons/key.svg',
                                  height: 18,
                                  fit: BoxFit.scaleDown))),
                      SizedBox(width: 20),
                      Expanded(
                          flex: 5,
                          child: Text("Select SSH keys",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xffBBBBBB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)))),
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset('assets/svg/icons/dropdown.svg',
                            height: 15.h, fit: BoxFit.scaleDown),
                      )
                    ]),
                  ),
                ],
              ),
              SizedBox(height: 35),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Network",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 18,
                            fontWeight: FontWeight.w600))),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/svg/icons/checkbox.svg',
                      height: 18, fit: BoxFit.scaleDown),
                  SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                        text: "Gunakan IP Publik",
                        style: GoogleFonts.manrope(
                            textStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xff232226),
                                fontWeight: FontWeight.w400)),
                        children: [
                          TextSpan(
                              text: " (+Rp 21.000)",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff009EFF),
                                      fontWeight: FontWeight.w400)))
                        ]),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Private Network",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Color(0xff232226),
                              fontSize: 14,
                              fontWeight: FontWeight.w500))),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffbbbbbb),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Row(children: [
                      Container(
                          width: 45.w,
                          decoration: BoxDecoration(
                            color: Color(0xffF1F1F1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Center(
                              child: SvgPicture.asset(
                                  'assets/svg/icons/hierarchy.svg',
                                  height: 18,
                                  fit: BoxFit.scaleDown))),
                      SizedBox(width: 20),
                      Expanded(
                          flex: 5,
                          child: Text("Select Private Network",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xffBBBBBB),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)))),
                      Expanded(
                        flex: 1,
                        child: SvgPicture.asset('assets/svg/icons/dropdown.svg',
                            height: 15.h, fit: BoxFit.scaleDown),
                      )
                    ]),
                  ),
                ],
              ),
              SizedBox(height: 40)
            ],
          ),
        ),
      )),
    );
  }

  Widget planList() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: [1, 2, 3, 4].length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: (MediaQuery.of(context).size.width / 2) - 60,
          crossAxisSpacing: 14,
          crossAxisCount: 2,
          mainAxisSpacing: 14),
      itemBuilder: (context, index) {
        return Container(
          width: 145.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(width: 1.0, color: const Color(0xFFBBBBBB)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: RichText(
                      text: TextSpan(
                          text: "Rp 50.000",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff009EFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          children: [
                        TextSpan(
                            text: "/month",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    color: Color(0xffBBBBBB),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)))
                      ])),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: RichText(
                      text: TextSpan(
                          text: "Rp 68",
                          style: GoogleFonts.manrope(
                              textStyle: TextStyle(
                                  color: Color(0xff232226),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                          children: [
                        TextSpan(
                            text: "/month",
                            style: GoogleFonts.manrope(
                                textStyle: TextStyle(
                                    color: Color(0xffBBBBBB),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400)))
                      ])),
                ),
                SizedBox(height: 5),
                Divider(
                  thickness: 1,
                  color: Color(0xffBBBBBB),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                    'assets/svg/icons/checklist-circle.svg',
                                    height: 12.h,
                                    fit: BoxFit.scaleDown),
                                SizedBox(width: 5),
                                Text("1 CPU",
                                    style: GoogleFonts.manrope(
                                        textStyle: TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600)))
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                    'assets/svg/icons/checklist-circle.svg',
                                    height: 12.h,
                                    fit: BoxFit.scaleDown),
                                SizedBox(width: 5),
                                Text("30 Disk",
                                    style: GoogleFonts.manrope(
                                        textStyle: TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600)))
                              ],
                            ),
                          ]),
                      SizedBox(height: 14),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                              'assets/svg/icons/checklist-circle.svg',
                              height: 12.h,
                              fit: BoxFit.scaleDown),
                          SizedBox(width: 5),
                          Text("1 GB RAM",
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Color(0xff232226),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600)))
                        ],
                      ),
                    ],
                  ),
                )
              ]),
        );
      },
    );
  }

  Widget osList() {
    return Column(children: [
      Row(
        children: [osItem(), SizedBox(width: 20), osItem()],
      ),
      SizedBox(height: 20),
      Row(
        children: [osItem(), SizedBox(width: 20), osItem()],
      ),
      SizedBox(height: 20),
      Row(
        children: [osItem(), SizedBox(width: 20), osItem()],
      ),
    ]);
  }

  Widget osItem() {
    return Flexible(
      flex: 1,
      child: Container(
        height: 41,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xffF1F1F1),
            border: Border.all(
              color: const Color(0xffbbbbbb),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          Image.asset(
            "assets/images/icons/ubuntu.png",
            height: 20,
          ),
          SizedBox(width: 10),
          Text("Ubuntu",
              style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                      color: Color(0xff232226),
                      fontSize: 12,
                      fontWeight: FontWeight.w600)))
        ]),
      ),
    );
  }

  Widget bottomNav() {
    return Container(
      width: ScreenUtil().screenWidth,
      height: 75,
      color: Color(0xff009EFF),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Summary",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500))),
            RichText(
                text: TextSpan(
                    text: "Rp 100.000",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    children: [
                  TextSpan(
                      text: "/month",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Color(0xff5CC1FF),
                              fontSize: 12,
                              fontWeight: FontWeight.w700)))
                ]))
          ],
        ),
        MaterialButton(
          minWidth: 122.w,
          height: 40.h,
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {},
          child: Text(
            "Confirm",
            style: GoogleFonts.manrope(
                textStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff009EFF),
                    fontWeight: FontWeight.w700)),
          ),
        )
      ]),
    );
  }
}
