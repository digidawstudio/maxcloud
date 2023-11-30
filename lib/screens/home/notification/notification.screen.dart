import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:maxcloud/bloc/notifications/notifications.bloc.dart';
import 'package:maxcloud/bloc/notifications/read-all-notifcations.bloc.dart';
import 'package:maxcloud/repository/notifications/notifications.model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenStateState();
}

class _NotificationScreenStateState extends State<NotificationScreen> {
  NotificationBloc? notificationBloc;
  ReadAllNotificationBloc? readAllNotificationBloc;

  final storage = const FlutterSecureStorage();

  String token = "";

  String type = "General";
  int page = 1;
  int limit = 10;

  int currentActive = 0; // 0 for general 1 for service

  List generalNotification = [
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
    "Top Up Balance",
  ];

  List serviceNotification = [
    "Virtual Machine Created",
    "Virtual Machine Created",
    "Virtual Machine Created",
    "Virtual Machine Created",
    "Virtual Machine Created",
  ];

  @override
  void initState() {
    notificationBloc = BlocProvider.of<NotificationBloc>(context);
    readAllNotificationBloc = BlocProvider.of<ReadAllNotificationBloc>(context);

    getAccessToken();
    super.initState();
  }

  void getAccessToken() async {
    String? accessToken = await storage.read(key: 'accessToken');
    notificationBloc
        ?.add(FetchNotificationEvent(accessToken ?? "", type, page, limit));
    setState(() {
      token = accessToken!;
    });
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
            Text("Notification",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
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
      body: BlocBuilder<ReadAllNotificationBloc, ReadAllNotificationState>(
          builder: (context, state) {
        if (state is LoadedReadAllNotificationState) {
          notificationBloc
              ?.add(FetchNotificationEvent(token, type, page, limit));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              borderRadius: BorderRadius.circular(5.r),
              elevation: 3,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.only(
                    left: 25.w, right: 25.w, bottom: 10.h, top: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              notificationBloc?.add(FetchNotificationEvent(
                                  token, "General", page, limit));
                              setState(() {
                                currentActive = 0;
                              });
                            },
                            child: ToggleButton("General")),
                        Expanded(child: Container()),
                        GestureDetector(
                            onTap: () {
                              notificationBloc?.add(FetchNotificationEvent(
                                  token, "Service", page, limit));
                              setState(() {
                                currentActive = 1;
                              });
                            },
                            child: ToggleButton("Service")),
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        readAllNotificationBloc
                            ?.add(PostReadAllNotificationEvent(token));
                      },
                      child: Text(
                        "Mark all as read",
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff009EFF),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: BlocBuilder<NotificationBloc, NotificationState>(
                  builder: (context, state) {
                if (state is LoadingNotificationState) {
                  return Center(
                      child: LoadingAnimationWidget.waveDots(
                    color: Color.fromARGB(255, 198, 198, 198),
                    size: 40,
                  ));
                }

                if (state is LoadedNotificationState) {
                  return ListView.builder(
                    itemCount: currentActive == 0
                        ? state.data.data?.notifData?.length
                        : state.data.data?.notifData?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) => NotificationItem(
                        currentActive == 0
                            ? state.data.data?.notifData![i]
                            : state.data.data?.notifData![i]),
                  );
                }
                return Container();
              }),
            )
          ],
        );
      }),
    );
  }

  Widget NotificationItem(NotifData? notifData) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
      color: notifData?.readAt != null
          ? const Color(0xffE3F3FD)
          : const Color(0xfff1f1f1f1),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                notifData?.title ?? "",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xff232226),
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ),
              Expanded(child: Container()),
              Text(
                notifData?.createdAtHrf ?? "",
                style: GoogleFonts.manrope(
                    textStyle: const TextStyle(
                        color: Color(0xffBBBBBB),
                        fontSize: 10,
                        fontWeight: FontWeight.w500)),
              )
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            notifData?.content ?? "",
            style: GoogleFonts.manrope(
                textStyle: const TextStyle(
                    color: Color(0xffBBBBBB),
                    fontSize: 12,
                    fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget ToggleButton(String type) {
    return Material(
      borderRadius: BorderRadius.circular(10.r),
      color: currentActive == 0 && type == "General"
          ? const Color(0xff009EFF)
          : currentActive == 1 && type == "Service"
              ? const Color(0xff009EFF)
              : const Color(0xf1f1f1f1),
      child: SizedBox(
        height: 39.h,
        width: 140.w,
        child: Center(
            child: Text(
          type,
          style: GoogleFonts.manrope(
              textStyle: TextStyle(
                  color: currentActive == 0 && type == "General"
                      ? Colors.white
                      : currentActive == 1 && type == "Service"
                          ? Colors.white
                          : const Color(0xffbbbbbb),
                  fontSize: 14,
                  fontWeight: FontWeight.w700)),
        )),
      ),
    );
  }
}
