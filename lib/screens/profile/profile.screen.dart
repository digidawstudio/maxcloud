import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/bloc/profile/profile.bloc.dart';
import 'package:maxcloud/bloc/user/user.bloc.dart';
import 'package:maxcloud/repository/profile/updateprofile.model.dart';
import 'package:maxcloud/services/api.services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc? profileBloc;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  List<dynamic> countryData = [];
  List<dynamic> provinceData = [];
  List<dynamic> cityData = [];
  List<dynamic> districtData = [];
  String selectedProvince = "";
  String selectedCity = "";

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);

    final LoadedProfileState profileState =
        BlocProvider.of<ProfileBloc>(context).state as LoadedProfileState;

    fullNameController.text = profileState.data.data?.firstName ?? "";
    lastNameController.text = profileState.data.data?.lastName ?? "";
    phoneController.text = profileState.data.data?.phone ?? "";
    addressController.text = profileState.data.data?.address ?? "";

    getCountry();

    super.initState();
  }

  void getCountry() async {
    final Response snap = await ApiServices.placesLookup(PlaceType.country);

    print(snap.data);

    if (snap.statusCode == 200) {
      countryData = snap.data["data"];
    } else {
      print("error");
    }
  }

  void getProvince() async {
    final Response snap = await ApiServices.placesLookup(PlaceType.province);

    print(snap.data);

    if (snap.statusCode == 200) {
      setState(() {
        provinceData = snap.data["data"];
      });
    } else {
      print("error");
    }
  }

  void getCity() async {
    final Response snap = await ApiServices.placesLookup(PlaceType.city, param: "?province_id=$selectedProvince");

    print(snap.data);

    if (snap.statusCode == 200) {
      cityData = snap.data["data"];
    } else {
      print("error");
    }
  }

  void getDistrict() async {
    final Response snap = await ApiServices.placesLookup(PlaceType.district, param: "?city_id=$selectedCity");

    print(snap.data);

    if (snap.statusCode == 200) {
      districtData = snap.data["data"];
    } else {
      print("error");
    }
  }

  final storage = const FlutterSecureStorage();

  getAccessToken() async {
    return await storage.read(key: 'accessToken');
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
            Text(
              "Profile",
              style: GoogleFonts.manrope(
                textStyle: const TextStyle(
                    color: Color(0xff353333),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
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
      body: Builder(builder: (context) {
        return SafeArea(child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is LoadedProfileState) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/elon.jpg',
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(state.data.data?.fullName ?? "",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 24,
                                fontWeight: FontWeight.w600))),
                    const SizedBox(height: 4),
                    Text("${state.data.data?.phone}",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xffBBBBBB),
                                fontSize: 13,
                                fontWeight: FontWeight.w500))),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/svg/icons/edit-profile.svg',
                                height: 28,
                                fit: BoxFit.scaleDown),
                            const SizedBox(width: 10),
                            Text("Edit Profile",
                                style: GoogleFonts.manrope(
                                    textStyle: const TextStyle(
                                        color: Color(0xff232226),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)))
                          ]),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 1,
                      color: Color(0xffBBBBBB),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("First Name",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    controller: fullNameController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Full Name',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Last Name",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: lastNameController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Full Name',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone Number",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Phone Number',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Address",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    controller: addressController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Address',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Country",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Country',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Province",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Province',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select City",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'City',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select District",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'District',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  BlocBuilder<UpdateUserBloc, UpdateUserState>(
                                      builder: (context, state) {
                                return MaterialButton(
                                  minWidth: double.infinity,
                                  height: 45,
                                  elevation: 0,
                                  color: const Color(0xff009EFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  onPressed: state is LoadingUpdateState
                                      ? null
                                      : () async {
                                          BlocProvider.of<UpdateUserBloc>(
                                                  context)
                                              .add(
                                                  UpdateUserEvent(
                                                      await getAccessToken(),
                                                      UpdateProfile(
                                                          address:
                                                              addressController
                                                                  .text,
                                                          firstName:
                                                              fullNameController
                                                                  .text,
                                                          lastName:
                                                              lastNameController
                                                                  .text,
                                                          phone: phoneController
                                                              .text,
                                                          cityId: "1102",
                                                          countryId: 79,
                                                          districtId: "1101010",
                                                          provinceId: "11")));
                                        },
                                  child: state is LoadingUpdateState
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          "Update",
                                          style: GoogleFonts.manrope(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                );
                              }),
                            ),
                          ],
                        )),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/svg/icons/change-password.svg',
                                height: 28,
                                fit: BoxFit.scaleDown),
                            const SizedBox(width: 10),
                            Text("Change Password",
                                style: GoogleFonts.manrope(
                                    textStyle: const TextStyle(
                                        color: Color(0xff232226),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)))
                          ]),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 1,
                      color: Color(0xffBBBBBB),
                    ),
                    const SizedBox(height: 5),
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
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Masukkan password lama anda',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("New Password",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText: 'Masukkan password baru anda',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Password Confirmation",
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            color: Color(0xff232226),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))),
                                const SizedBox(height: 10),
                                TextField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: _phoneController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 10.5, horizontal: 15),
                                      isDense: true,
                                      hintText:
                                          'Masukkan konfirmasi password baru anda',
                                      hintStyle: GoogleFonts.manrope(
                                          textStyle: const TextStyle(
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
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: MaterialButton(
                                minWidth: double.infinity,
                                height: 45,
                                elevation: 0,
                                color: const Color(0xff009EFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Update",
                                  style: GoogleFonts.manrope(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }));
      }),
    );
  }
}
