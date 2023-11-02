import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maxcloud/bloc/helpdesk/helpdesk.bloc.dart';
import 'package:maxcloud/repository/tickets.model.dart';
import 'package:maxcloud/screens/auth/login-screen.dart';
import 'package:maxcloud/screens/help/helpdesk-detail.screen.dart';
import 'package:maxcloud/utils/widgets.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({super.key});

  @override
  State<HelpDeskScreen> createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  HelpDeskBloc helpdeskBloc = HelpDeskBloc();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  FlutterSecureStorage storage = FlutterSecureStorage();

  List defaultState = [
    "test",
    "test",
    "test",
    "test",
    "test",
    "test",
  ];

  List savedState = [
    "test",
    "test",
    "test",
  ];

  bool isSavedPressed = false;

  @override
  void initState() {
    storage.read(key: "accessToken").then((token) {
      helpdeskBloc = BlocProvider.of<HelpDeskBloc>(context);

      if (token != null) {
        helpdeskBloc.add(FetchHelpDeskItemsEvent(token, 1));
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(isSavedPressed ? "Saved" : "Help Desk",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff353333),
                        fontSize: 25,
                        fontWeight: FontWeight.w600))),
          ],
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         setState(() {
        //           isSavedPressed = !isSavedPressed;
        //         });
        //       },
        //       icon: Image.asset(
        //         "assets/icons/bookmark.png",
        //         color: isSavedPressed ? Colors.transparent : Color(0xff232226),
        //       ))
        // ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 13.h),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: MaterialButton(
                          minWidth: 171.w,
                          height: 30.h,
                          elevation: 0,
                          color: Color(0xff009EFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                enableDrag: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    height: 500.h,
                                    padding: EdgeInsets.all(25.w),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Subject"),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              hintText: "Free Delivery",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r))),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Flexible(
                                          child: Container(
                                            height: 90.h,
                                            child: Row(
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Select Department"),
                                                      SizedBox(
                                                        height: 9.h,
                                                      ),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Billing",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Select Department"),
                                                      SizedBox(
                                                        height: 9.h,
                                                      ),
                                                      TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintText: "Billing",
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Text("Message"),
                                        SizedBox(
                                          height: 9.h,
                                        ),
                                        Flexible(
                                          child: SizedBox(
                                            height: 160.h,
                                            child: TextFormField(
                                              maxLines: 20,
                                              decoration: InputDecoration(
                                                  hintText: "Type Reply",
                                                  border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r))),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {},
                                                child: Text("Send"))
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/svg/icons/plus-icon.svg',
                                  height: 11.h, fit: BoxFit.scaleDown),
                              SizedBox(width: 12.w),
                              Text(
                                "New Ticket",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Flexible(
                        flex: 2,
                        child: MaterialButton(
                          height: 30.h,
                          elevation: 0,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xffBBBBBB)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          onPressed: () {},
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Filter",
                                style: GoogleFonts.manrope(
                                    textStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xff353333),
                                        fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(width: 30),
                              SvgPicture.asset('assets/svg/icons/filter.svg',
                                  height: 15.h, fit: BoxFit.scaleDown),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Flexible(
                child: BlocBuilder<HelpDeskBloc, FetchHelpDeskItemsState>(
                  builder: (context, state) {
                    if (state is ErrorFetchHelpDeskState) {
                      print("kudaniil haml");
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      });
                    }

                    if (state is LoadingFetchHelpDeskItemsState) {
                      return CustomWidget.loader();
                    }

                    if (state is LoadedFetchHelpDeskItemsState) {
                      return Container(
                        height: ScreenUtil().screenHeight,
                        child: ListView.builder(
                          // shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                            vertical: 15.h,
                          ),
                          itemCount: isSavedPressed
                              ? savedState.length
                              : state.data.data?.data.length,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HelpDeskDetailScreen(
                                              ticket:
                                                  state.data.data?.data[i] ??
                                                      TicketData())));
                            },
                            child: helpdeskItems(state.data.data?.data[i]),
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget helpdeskItems(TicketData? ticket) {
  return SimpleShadow(
    opacity: 0.3, // Default: 0.5
    color: Colors.grey, // Default: Black
    offset: Offset(0, 5), // Default: Offset(2, 2)
    sigma: 7, // Default: 2
    child: Container(
      height: 184.h,
      margin: EdgeInsets.only(bottom: 25.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket?.subject ?? "",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xff232226),
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    ticket?.createdAt ?? "",
                    style: GoogleFonts.manrope(
                        textStyle: TextStyle(
                            color: Color(0xffBBBBBB),
                            fontSize: 10,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                width: 30.w,
                child: Stack(
                  children: [
                    Positioned(
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 10.r,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10.r,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 7.w,
              ),
              SvgPicture.asset('assets/svg/icons/bookmark.svg',
                  height: 15, fit: BoxFit.scaleDown)
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            ticket?.content ?? "",
            style: GoogleFonts.manrope(
                textStyle: TextStyle(
                    color: Color(0xffBBBBBB),
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
          Expanded(child: Container()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/icons/message.svg',
                  height: 15, fit: BoxFit.scaleDown),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "4",
                style: GoogleFonts.manrope(
                    textStyle: TextStyle(
                        color: Color(0xff232226),
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
              ),
              Expanded(child: Container()),
              Flexible(
                  child: CustomWidget.Chip(
                      text: ticket?.status ?? "",
                      width: 48,
                      height: 14,
                      color: Color(0xffE9FCE5),
                      radius: 5.r,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      textColor: Color(0xff02D430))),
              SizedBox(
                width: 10.w,
              ),
              Flexible(
                  child: CustomWidget.Chip(
                      text: ticket?.department ?? "",
                      width: 48,
                      height: 14,
                      color: Color(0xffAABDFF),
                      radius: 5.r,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      textColor: Color(0xff18369E))),
              SizedBox(
                width: 10.w,
              ),
              CustomWidget.Chip(
                text: ticket?.service ?? "N/A",
                width: 70,
                height: 14,
                fontSize: 8,
                color: Colors.white,
                radius: 5.r,
                useBorder: true,
                fontWeight: FontWeight.w500,
                textColor: Color(0xff232226),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
