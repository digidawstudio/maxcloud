import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxcloud/bloc/helpdesk/helpdesk.bloc.dart';
import 'package:maxcloud/repository/tickets.model.dart';
import 'package:maxcloud/screens/auth/login-screen.dart';
import 'package:maxcloud/screens/help/helpdesk-detail.screen.dart';
import 'package:maxcloud/services/api.services.dart';
import 'package:maxcloud/utils/widget.classes/HelpdeskFilterDialog.dart';
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
  TextEditingController deptController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  FlutterSecureStorage storage = const FlutterSecureStorage();

  List<String> dept = ["Billing", "Support"];

  List<String> services = ["Virtual Machine"];
  List<XFile> files = [];
  ImagePicker picker = ImagePicker();

  int selectedDept = 0;
  int selectedService = 0;

  bool isSavedPressed = false;
  bool isSendTicketLoading = false;
  String token = "";

  @override
  void initState() {
    getTickets();
    setState(() {
      deptController.text = dept[selectedDept];
      serviceController.text = services[selectedService];
    });

    super.initState();
  }

  Future pickImage(StateSetter thisSetState) async {
    print("get image");
    var img = await picker.pickMultiImage(imageQuality: 70);

    thisSetState(() {
      files.addAll(img);
      print(files);
    });
  }

  void getTickets() {
    storage.read(key: "accessToken").then((token) {
      helpdeskBloc = BlocProvider.of<HelpDeskBloc>(context);

      if (token != null) {
        helpdeskBloc.add(FetchHelpDeskItemsEvent(token, 1));
        this.token = token;
        setState(() {});
      } else {
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
  }

  void createTicket(BuildContext currentContext) async {
    Navigator.pop(currentContext);
    isSendTicketLoading = true;
    setState(() {});
    ApiServices.createNewTicket(token, contentController.text,
            subjectController.text, deptController.text,
            serviceType: serviceController.text, attachments: files)
        .then(
      (response) {
        if (response.runtimeType == Response) {
          Flushbar(
            duration: Duration(seconds: 2),
            message: "Ticket Created!",
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.blueAccent,
            messageColor: Colors.white,
          ).show(context);

          getTickets();
          files = [];
          contentController.text = "";
          subjectController.text = "";
          setState(() {});
        } else {
          print(response);
          Flushbar(
            duration: Duration(seconds: 2),
            message: "Error occured: $response",
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            messageColor: Colors.white,
          ).show(context);
        }
        isSendTicketLoading = false;
        setState(() {});
      },
    ).catchError((err) {
      isSendTicketLoading = false;
      setState(() {});
      Navigator.pop(currentContext);
      Flushbar(
        duration: Duration(seconds: 2),
        message: "Error occured: $err",
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
      ).show(context);
      print(err);
    });
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
            Text(isSavedPressed ? "Saved" : "Help Desk",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
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
          child: isSendTicketLoading
              ? Center(
                  child: LoadingAnimationWidget.waveDots(
                  color: Color.fromARGB(255, 198, 198, 198),
                  size: 40,
                ))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 13.h),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: MaterialButton(
                                minWidth: 171.w,
                                height: 30.h,
                                elevation: 0,
                                color: const Color(0xff009EFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (thisContext) {
                                        return StatefulBuilder(
                                          builder: (context, thisSetState) =>
                                              Container(
                                            height: 600.h,
                                            padding: EdgeInsets.all(25.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: Colors.white),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Enter Subject"),
                                                SizedBox(
                                                  height: 9.h,
                                                ),
                                                TextFormField(
                                                  controller: subjectController,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  decoration: InputDecoration(
                                                      hintText: "Free Delivery",
                                                      border: OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r))),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Flexible(
                                                  child: SizedBox(
                                                    height: 90.h,
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                  "Select Department"),
                                                              SizedBox(
                                                                height: 9.h,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  showModalBottomSheet(
                                                                      context:
                                                                          thisContext,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .transparent,
                                                                      builder:
                                                                          (currentContext) {
                                                                        return selector(
                                                                            currentContext,
                                                                            true,
                                                                            dept);
                                                                      });
                                                                },
                                                                child:
                                                                    TextFormField(
                                                                  controller:
                                                                      deptController,
                                                                  enabled:
                                                                      false,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Billing",
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.black),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
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
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      thisContext,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  builder:
                                                                      (currentContext) {
                                                                    return selector(
                                                                        currentContext,
                                                                        false,
                                                                        services);
                                                                  });
                                                            },
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Text(
                                                                    "Select Service"),
                                                                SizedBox(
                                                                  height: 9.h,
                                                                ),
                                                                TextFormField(
                                                                  enabled:
                                                                      false,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                  controller:
                                                                      serviceController,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Billing",
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                              color: Colors.black),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.r),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const Text("Message"),
                                                SizedBox(
                                                  height: 9.h,
                                                ),
                                                Flexible(
                                                  child: SizedBox(
                                                    height: 160.h,
                                                    child: TextFormField(
                                                      controller:
                                                          contentController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      maxLines: 20,
                                                      decoration: InputDecoration(
                                                          hintText: "Content",
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  const BorderSide(
                                                                      color: Colors
                                                                          .black),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r))),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  width:
                                                      ScreenUtil().screenWidth,
                                                  height:
                                                      files.isEmpty ? 0 : 50.h,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: files.length,
                                                    itemBuilder: (context, i) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          showImageViewer(
                                                              context,
                                                              useSafeArea: true,
                                                              swipeDismissible:
                                                                  true,
                                                              Image.file(File(
                                                                      files[i]
                                                                          .path))
                                                                  .image);
                                                        },
                                                        child: Container(
                                                          height: 36.h,
                                                          width: 36.w,
                                                          child: Image.file(
                                                              File(files[i]
                                                                  .path)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                files.length >= 5
                                                    ? Container()
                                                    : GestureDetector(
                                                        onTap: () {
                                                          pickImage(
                                                              thisSetState);
                                                        },
                                                        child: Container(
                                                          height: 36.h,
                                                          width: 36.h,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r)),
                                                          child: Center(
                                                            child: Text("+"),
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
                                                        onPressed: () {
                                                          createTicket(
                                                              thisContext);
                                                        },
                                                        child:
                                                            const Text("Send"))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/svg/icons/plus-icon.svg',
                                        height: 11.h,
                                        fit: BoxFit.scaleDown),
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
                            const Spacer(),
                            Flexible(
                              flex: 2,
                              child: MaterialButton(
                                height: 30.h,
                                elevation: 0,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 1, color: Color(0xffBBBBBB)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: this.context,
                                      builder: (ctx) => HelpdeskFilterDialog(
                                            onFilter: () async {
                                              Navigator.pop(this.context);
                                            },
                                          ));
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Filter",
                                      style: GoogleFonts.manrope(
                                          textStyle: TextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xff353333),
                                              fontWeight: FontWeight.w400)),
                                    ),
                                    const SizedBox(width: 30),
                                    SvgPicture.asset(
                                        'assets/svg/icons/filter.svg',
                                        height: 15.h,
                                        fit: BoxFit.scaleDown),
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
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                  (route) => false);
                            });
                          }

                          if (state is LoadingFetchHelpDeskItemsState) {
                            return Center(
                                child: LoadingAnimationWidget.waveDots(
                              color: Color.fromARGB(255, 198, 198, 198),
                              size: 40,
                            ));
                          }

                          if (state is LoadedFetchHelpDeskItemsState) {
                            return Container(
                              height: ScreenUtil().screenHeight,
                              child: ListView.builder(
                                // shrinkWrap: true,
                                padding: EdgeInsets.symmetric(
                                  // horizontal: 25.w,
                                  vertical: 15.h,
                                ),
                                itemCount: state.data.data?.data.length,
                                itemBuilder: (context, i) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HelpDeskDetailScreen(
                                                    ticket: state.data.data
                                                            ?.data[i] ??
                                                        TicketData())));
                                  },
                                  child:
                                      helpdeskItems(state.data.data?.data[i]),
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

  Widget selector(
      BuildContext currentContext, bool isDept, List<String> items) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.r,
        ),
        color: Colors.white,
      ),
      child: CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (item) {
          setState(() {
            if (isDept) {
              deptController.text = dept[item];
            } else {
              serviceController.text = services[item];
            }
          });
        },
        useMagnifier: true,
        children: items.map((e) => Text(e)).toList(),
      ),
    );
  }

  Widget helpdeskItems(TicketData? ticket) {
    return SimpleShadow(
      opacity: 0.3, // Default: 0.5
      color: Colors.grey, // Default: Black
      offset: const Offset(0, 5), // Default: Offset(2, 2)
      sigma: 7, // Default: 2
      child: Container(
        height: 184.h,
        margin: EdgeInsets.only(bottom: 25.h, left: 25.w, right: 25.w),
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
                    SizedBox(
                      width: 220.w,
                      child: Text(
                        ticket?.subject ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      ticket?.createdAt ?? "",
                      style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                              color: Color(0xffBBBBBB),
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: 30.w,
                  child: Stack(
                    children: ticket!.members!.map((e) {
                      return Positioned(
                        child: CircleAvatar(
                          backgroundColor:
                              e.isAdmin == false ? Colors.blue : Colors.red,
                          radius: 10.r,
                          child: Text('${e.name![0]}',
                              style: GoogleFonts.manrope(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontWeight: FontWeight.w700))),
                        ),
                      );
                    }).toList(),
                    // children: [
                    //   Positioned(
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.blue,
                    //       radius: 10.r,
                    //       child: Text(
                    //           '${ticket?.members![0].isAdmin! == false ? ticket?.members![0].name![0] : ""}',
                    //           style: GoogleFonts.manrope(
                    //               textStyle: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 8,
                    //                   fontWeight: FontWeight.w700))),
                    //     ),
                    //   ),
                    //   Positioned(
                    //     right: 0,
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.red,
                    //       radius: 10.r,
                    //       child: Text(
                    //           '${ticket?.members![0].isAdmin! == true ? ticket?.members![0].name![0] : ""}',
                    //           style: GoogleFonts.manrope(
                    //               textStyle: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 8,
                    //                   fontWeight: FontWeight.w700))),
                    //     ),
                    //   )
                    // ],
                  ),
                ),
                // SizedBox(
                //   width: 7.w,
                // ),
                // SvgPicture.asset('assets/svg/icons/bookmark.svg',
                //     height: 15, fit: BoxFit.scaleDown)
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              ticket?.content ?? "",
              style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
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
                  ticket?.conversationCount.toString() ?? "0",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Color(0xff232226),
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(child: Container()),
                Flexible(
                  child: CustomWidget.Chip(
                    text: ticket?.status ?? "",
                    height: 14,
                    color: ticket?.status == "Open"
                        ? Color(0xffE9FCE5)
                        : ticket?.status == "Answered" ||
                                ticket?.status == "Customer Reply"
                            ? Color.fromARGB(255, 255, 226, 121)
                            : Colors.red,
                    radius: 5.r,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    textColor: ticket?.status == "Open"
                        ? const Color(0xff02D430)
                        : Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                    child: CustomWidget.Chip(
                        text: ticket?.department ?? "",
                        height: 14,
                        color: const Color(0xffAABDFF),
                        radius: 5.r,
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        textColor: const Color(0xff18369E))),
                SizedBox(
                  width: 10.w,
                ),
                CustomWidget.Chip(
                  text: ticket?.service ?? "N/A",
                  height: 14,
                  width: ticket?.service == null ? null : 48,
                  fontSize: 8,
                  color: Colors.white,
                  radius: 5.r,
                  useBorder: true,
                  fontWeight: FontWeight.w500,
                  textColor: const Color(0xff232226),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
