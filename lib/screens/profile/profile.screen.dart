import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxcloud/bloc/auth/auth.bloc.dart';
import 'package:maxcloud/bloc/profile/change-password.bloc.dart';
import 'package:maxcloud/bloc/profile/profile.bloc.dart';
import 'package:maxcloud/bloc/user/user.bloc.dart';
import 'package:maxcloud/repository/profile/updateprofile.model.dart';
import 'package:maxcloud/screens/auth/login-screen.dart';
import 'package:maxcloud/services/api.services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc? profileBloc;
  ChangePasswordBloc? changePasswordBloc;
  AuthBloc? authBloc;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  List<DropdownMenuItem> countryData = [
    const DropdownMenuItem(
        value: "Select Country", child: Text("Select Country"))
  ];
  List<DropdownMenuItem> provinceData = [
    const DropdownMenuItem(
        value: "Select Province", child: Text("Select Province"))
  ];
  List<DropdownMenuItem> cityData = [
    const DropdownMenuItem(value: "Select City", child: Text("Select City"))
  ];
  List<DropdownMenuItem> districtData = [
    const DropdownMenuItem(
        value: "Select District", child: Text("Select District"))
  ];

  List<dynamic> dCountryData = [];
  List<dynamic> dProvinceData = [];
  List<dynamic> dCityData = [];
  List<dynamic> dDistrictData = [];

  String selectedCountry = "Select Country";
  String selectedProvince = "Select Province";
  String selectedCity = "Select City";
  String selectedDistrict = "Select District";

  String selectedCountryId = "";
  String selectedProvinceId = "";
  String selectedCityId = "";
  String selectedDistrictId = "";

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);

    final LoadedProfileState profileState =
        BlocProvider.of<ProfileBloc>(context).state as LoadedProfileState;

    fullNameController.text = profileState.data.data?.firstName ?? "";
    lastNameController.text = profileState.data.data?.lastName ?? "";
    phoneController.text = profileState.data.data?.phone ?? "";
    addressController.text = profileState.data.data?.address ?? "";

    getCountry();
    getProvince(initial: true);

    super.initState();
  }

  void getCountry() async {
    final Response snap = await ApiServices.placesLookup(PlaceType.country);

    print(snap.data);

    if (snap.statusCode == 200) {
      snap.data["data"].forEach((value) {
        countryData.add(DropdownMenuItem(
            value: value['name'],
            child: Text(toBeginningOfSentenceCase(value['name']) ?? "")));
      });

      setState(() {
        dCountryData = snap.data["data"];
        selectedCountry = snap.data["data"][0]["name"];
        selectedCountryId = snap.data["data"][0]["id"].toString();
      });
    } else {
      print("error");
    }
  }

  void getProvince({bool initial = false}) async {
    final Response snap = await ApiServices.placesLookup(PlaceType.province);
    final LoadedProfileState profileState =
        BlocProvider.of<ProfileBloc>(context).state as LoadedProfileState;

    print(snap.data["data"]);

    if (snap.statusCode == 200) {
      List<DropdownMenuItem> _provinceData = [];

      snap.data["data"]["data"].forEach((value) {
        _provinceData.add(DropdownMenuItem(
            value: value['name'],
            child: Text(toBeginningOfSentenceCase(value['name']) ?? "")));
      });

      if (initial && profileState.data.data?.province != null) {
        setState(() {
          selectedProvince = profileState.data.data?.province?.name ?? "";
          selectedProvinceId =
              profileState.data.data?.province?.id.toString() ?? "";
        });
      } else {
        setState(() {
          selectedProvince = snap.data["data"]["data"][0]["name"];
          selectedProvinceId = snap.data["data"]["data"][0]["id"].toString();
        });
      }

      setState(() {
        provinceData = _provinceData;
        dProvinceData = snap.data["data"]["data"];
      });

      getCity(
          profileState.data.data?.province != null
              ? profileState.data.data?.province?.id.toString() ?? ""
              : snap.data["data"]["data"][0]["id"].toString(),
          initial: initial ? true : false);
    } else {
      print("error");
    }
  }

  void getCity(String provinceId, {bool initial = false}) async {
    final Response snap = await ApiServices.placesLookup(PlaceType.city,
        param: "?province_id=$provinceId");

    final LoadedProfileState profileState =
        BlocProvider.of<ProfileBloc>(context).state as LoadedProfileState;

    print(snap.data);

    if (snap.statusCode == 200) {
      List<DropdownMenuItem> _cityData = [];

      snap.data["data"]["data"].forEach((value) {
        _cityData.add(DropdownMenuItem(
            value: value['name'],
            child: Text(toBeginningOfSentenceCase(value['name']) ?? "")));
      });

      if (initial && profileState.data.data?.city != null) {
        setState(() {
          selectedCity = profileState.data.data?.city?.name ?? "";
          selectedCityId = profileState.data.data?.city?.id.toString() ?? "";
        });
      } else {
        setState(() {
          selectedCity = snap.data["data"]["data"][0]["name"];
          selectedCityId = snap.data["data"]["data"][0]["id"].toString();
        });
      }

      setState(() {
        cityData = _cityData;
        dCityData = snap.data["data"]["data"];
      });

      getDistrict(
          profileState.data.data?.city != null
              ? profileState.data.data?.city?.id.toString() ?? ""
              : snap.data["data"]["data"][0]["id"].toString(),
          initial: initial ? true : false);
    } else {
      print("error");
    }
  }

  void getDistrict(String cityId, {bool initial = false}) async {
    final Response snap = await ApiServices.placesLookup(PlaceType.district,
        param: "?city_id=$cityId");

    final LoadedProfileState profileState =
        BlocProvider.of<ProfileBloc>(context).state as LoadedProfileState;

    print(snap.data);

    if (snap.statusCode == 200) {
      List<DropdownMenuItem> _districtData = [];

      snap.data["data"]["data"].forEach((value) {
        _districtData.add(DropdownMenuItem(
            value: value['name'],
            child: Text(toBeginningOfSentenceCase(value['name']) ?? "")));
      });

      if (initial && profileState.data.data?.district != null) {
        setState(() {
          selectedDistrict = profileState.data.data?.district?.name ?? "";
          selectedDistrictId =
              profileState.data.data?.district?.id.toString() ?? "";
        });
      } else {
        setState(() {
          selectedDistrict = snap.data["data"]["data"][0]["name"];
          selectedDistrictId = snap.data["data"]["data"][0]["id"].toString();
        });
      }

      setState(() {
        districtData = _districtData;
        dDistrictData = snap.data["data"]["data"];
      });
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
      body: SafeArea(child:
          BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
        if (state is LoadedProfileState) {
          return Container(
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
                  Text(state.data.data?.fullName ?? "",
                      style: GoogleFonts.manrope(
                          textStyle: TextStyle(
                              color: Color(0xff232226),
                              fontSize: 24,
                              fontWeight: FontWeight.w600))),
                  SizedBox(height: 4),
                  Text("${state.data.data?.phone}",
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
                              Text("First Name",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          color: Color(0xff232226),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                              SizedBox(height: 10),
                              TextField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.text,
                                  controller: fullNameController,
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
                              Text("Last Name",
                                  style: GoogleFonts.manrope(
                                      textStyle: TextStyle(
                                          color: Color(0xff232226),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                              SizedBox(height: 10),
                              TextField(
                                  autocorrect: false,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: lastNameController,
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
                                  controller: phoneController,
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
                                  controller: addressController,
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
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(
                                        0xFFBBBBBB), // Ubah warna border sesuai kebutuhan Anda
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                            value: selectedCountry,
                                            icon: SvgPicture.asset(
                                                'assets/svg/icons/dropdown.svg',
                                                height: 15,
                                                fit: BoxFit.scaleDown),
                                            iconSize: 24,
                                            elevation: 0,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            style: GoogleFonts.manrope(
                                                textStyle: TextStyle(
                                                    color: Color(0xff232226),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedCountry = newValue!;
                                              });
                                            },
                                            items: countryData))),
                              ),
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
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(
                                        0xFFBBBBBB), // Ubah warna border sesuai kebutuhan Anda
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          value: selectedProvince,
                                          icon: SvgPicture.asset(
                                              'assets/svg/icons/dropdown.svg',
                                              height: 15,
                                              fit: BoxFit.scaleDown),
                                          iconSize: 24,
                                          elevation: 0,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          style: GoogleFonts.manrope(
                                              textStyle: TextStyle(
                                                  color: Color(0xff232226),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          onChanged: (newValue) {
                                            var selected = dProvinceData
                                                .where((i) =>
                                                    i['name'] == newValue)
                                                .toList();

                                            getCity(
                                                selected[0]['id'].toString());

                                            setState(() {
                                              selectedProvince = newValue!;
                                              selectedProvinceId =
                                                  selected[0]['id'].toString();
                                            });
                                          },
                                          items: provinceData,
                                        ))),
                              ),
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
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(
                                        0xFFBBBBBB), // Ubah warna border sesuai kebutuhan Anda
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          value: selectedCity,
                                          icon: SvgPicture.asset(
                                              'assets/svg/icons/dropdown.svg',
                                              height: 15,
                                              fit: BoxFit.scaleDown),
                                          iconSize: 24,
                                          elevation: 0,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          style: GoogleFonts.manrope(
                                              textStyle: TextStyle(
                                                  color: Color(0xff232226),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          onChanged: (newValue) {
                                            var selected = dCityData
                                                .where((i) =>
                                                    i['name'] == newValue)
                                                .toList();

                                            getDistrict(
                                                selected[0]['id'].toString());

                                            setState(() {
                                              selectedCity = newValue!;
                                              selectedCityId =
                                                  selected[0]['id'].toString();
                                            });
                                          },
                                          items: cityData,
                                        ))),
                              ),
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
                              Container(
                                width: double.infinity,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Color(
                                        0xFFBBBBBB), // Ubah warna border sesuai kebutuhan Anda
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButton(
                                          value: selectedDistrict,
                                          icon: SvgPicture.asset(
                                              'assets/svg/icons/dropdown.svg',
                                              height: 15,
                                              fit: BoxFit.scaleDown),
                                          iconSize: 24,
                                          elevation: 0,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          style: GoogleFonts.manrope(
                                              textStyle: TextStyle(
                                                  color: Color(0xff232226),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          onChanged: (newValue) {
                                            var selected = dDistrictData
                                                .where((i) =>
                                                    i['name'] == newValue)
                                                .toList();

                                            setState(() {
                                              selectedDistrict = newValue!;
                                              selectedDistrictId =
                                                  selected[0]['id'].toString();
                                            });
                                          },
                                          items: districtData,
                                        ))),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: BlocBuilder<UpdateUserBloc, UpdateUserState>(
                                builder: (context, state) {
                              return MaterialButton(
                                minWidth: double.infinity,
                                height: 45,
                                elevation: 0,
                                color: Color(0xff009EFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                onPressed: state is LoadingUpdateState
                                    ? () {}
                                    : () async {
                                        BlocProvider.of<UpdateUserBloc>(context)
                                            .add(UpdateUserEvent(
                                                await getAccessToken(),
                                                UpdateProfile(
                                                    address:
                                                        addressController.text,
                                                    firstName:
                                                        fullNameController.text,
                                                    lastName:
                                                        lastNameController.text,
                                                    phone: phoneController.text,
                                                    countryId: int.parse(
                                                        selectedCountryId),
                                                    provinceId: int.parse(
                                                        selectedProvinceId),
                                                    cityId: int.parse(
                                                        selectedCityId),
                                                    districtId: int.parse(
                                                        selectedDistrictId))));
                                      },
                                child: state is LoadingUpdateState
                                    ? Center(
                                        child: LoadingAnimationWidget.waveDots(
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )
                                    : Text(
                                        "Update",
                                        style: GoogleFonts.manrope(
                                            textStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600)),
                                      ),
                              );
                            }),
                          ),
                        ],
                      )),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                              'assets/svg/icons/change-password.svg',
                              height: 28,
                              fit: BoxFit.scaleDown),
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
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                      builder: (context, state) {
                    return Padding(
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
                                    controller: currentPasswordController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                    controller: newPasswordController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                    controller: rePasswordController,
                                    style: GoogleFonts.manrope(
                                        textStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                onPressed: state is LoadingChangePasswordState
                                    ? () {}
                                    : () async {
                                        changePasswordBloc?.add(
                                            PostChangePasswordEvent(
                                                await getAccessToken(), {
                                          "current_password":
                                              currentPasswordController.text,
                                          "password":
                                              newPasswordController.text,
                                          "password_confirmation":
                                              rePasswordController.text
                                        }));
                                      },
                                child: state is LoadingChangePasswordState
                                    ? Center(
                                        child: LoadingAnimationWidget.waveDots(
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )
                                    : Text(
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
                        ));
                  }),
                  SizedBox(height: 20),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 45,
                        elevation: 0,
                        color: Color.fromARGB(255, 255, 0, 34),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        onPressed: state is LoadingAuthState
                            ? () {}
                            : () async {
                                authBloc?.add(LogoutEvent(getAccessToken()));
                                await storage.delete(key: 'accessToken');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                        child: state is LoadingAuthState
                            ? Center(
                                child: LoadingAnimationWidget.waveDots(
                                  color: Colors.white,
                                  size: 30,
                                ),
                              )
                            : Text(
                                "Logout",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                              ),
                      ),
                    );
                  }),
                  SizedBox(height: 40),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      })),
    );
  }
}
