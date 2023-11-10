// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:codebase_echo/codebase_echo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laravel_flutter_pusher/laravel_flutter_pusher.dart';
import 'package:maxcloud/repository/tickets/ticketsconv.model.dart';
import 'package:maxcloud/services/api.services.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
// import 'package:pusher_client/pusher_client.dart';

import '../../bloc/helpdesk/helpdesk.bloc.dart';
import '../../repository/tickets.model.dart';
import '../../utils/widgets.dart';

const REACT_APP_API_DOMAIN = "api.maxstage.id";
const REACT_APP_WS_KEY = "z6nhzsfjvci1xel1v70at30miaohq04s";
const REACT_APP_WS_CLUSTER = "mlg11";

// //Pusher
// PusherOptions options = PusherOptions(
//   cluster: REACT_APP_WS_CLUSTER,
//   host: REACT_APP_API_DOMAIN,
// );

// PusherClient pusherClient = PusherClient(REACT_APP_WS_KEY, options, enableLogging: true);

class HelpDeskDetailScreen extends StatefulWidget {
  final TicketData ticket;
  const HelpDeskDetailScreen({super.key, required this.ticket});

  @override
  State<HelpDeskDetailScreen> createState() => _HelpDeskDetailScreenState();
}

class _HelpDeskDetailScreenState extends State<HelpDeskDetailScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  ScrollController controller = ScrollController();
  BuildContext? messageBottomSheetContext;

  TextEditingController messageController = TextEditingController();
  TicketConversationBloc? ticketConv;
  // PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  late Echo echo;
  bool isConnected = false;
  List<String> listeningChannels = [];
  ConversationModel convModel = ConversationModel();
  List<ConversationData> convData = [];
  FocusNode messageFocus = FocusNode();

  // Echo echo =  Echo(client: pusher, broadcaster: EchoBroadcasterType.Pusher);
  final IOWebSocketChannel ticketWS = IOWebSocketChannel.connect(Uri.parse(
      'wss://api.maxstage.id/app/z6nhzsfjvci1xel1v70at30miaohq04s?protocol=7'));

  Echo setupWS() {
    final options = PusherOptions(
      host: REACT_APP_API_DOMAIN,
      cluster: REACT_APP_WS_CLUSTER,
      encrypted: true,
    );

    LaravelFlutterPusher pusher = LaravelFlutterPusher(
      REACT_APP_WS_KEY,
      options,
      enableLogging: true,
      onError: ((p0) => print(p0)),
      onConnectionStateChange: (p0) => print(p0.currentState),
    );

    // pusher.subscribe("ticket-conversation-${widget.ticket.token}").bind('.ticket.replied', (event) => print(event.toString()));

    Echo echo = Echo(client: pusher, broadcaster: EchoBroadcasterType.Pusher);

    echo
        .channel('ticket-conversation-${widget.ticket.token}')
        .listen('.ticket.replied', (cb) {
      print('message from websockets: ' + cb['conversation'].toString());
      if (cb['conversation']['is_damin'] == true) {
        convData.insert(0, ConversationData.fromJson(cb['conversation']));
      }
    });

    echo.connect();

    return echo;
  }

  void getConvData() {
    token().then((value) {
      ApiServices.fetchConversations(value ?? "", widget.ticket.token ?? "")
          .then((response) {
        if (response is Response) {
          if (response.statusCode == 200) {
            print(response.data);
            convModel = ConversationModel.fromJson(response.data);

            convData = convModel.data?.data ?? [];

            setState(() {});
          }
        } else if (response is DioException) {
          print(response.message);
        }
      });
    });
  }

  @override
  void initState() {
    // connectPusher();
    getConvData();
    ticketConv = BlocProvider.of<TicketConversationBloc>(context);

    // ticketWS.stream.listen((event) {
    //   print(event.toString());
    // });

    setupWS();

    // ticketWS.stream.listen((event) {
    //   print("connection ws: $event");
    // });

    // echoSet().channel('ticket-conversation-${widget.ticket.token}').listen('.ticket.replied', (data) {
    //   print("echoing to ticket conversation ${data}");
    // });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // controller.jumpTo(controller.position.maxScrollExtent);
    });

    // getMessage();

    super.initState();
  }

  void getMessage() {
    token().then((token) {
      BlocProvider.of<TicketConversationBloc>(context).add(
          FetchConversationEvent(token ?? "", 1, widget.ticket.token ?? ""));
    });
  }

  Future<String?> token() async {
    return await storage.read(key: "accessToken");
  }

  @override
  void dispose() {
    super.dispose();
    setupWS().disconnect();
  }

  @override
  Widget build(BuildContext context) {
    // print(pusher.connectionState);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          behavior: HitTestBehavior.opaque,
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Help Desk",
          style: TextStyle(color: Colors.black),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60.h,
        child: ButtonTheme(
          child: BlocBuilder<SendMessageBloc, SendMessageState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: widget.ticket.status == "Answered"
                    ? () {}
                    : () {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (currentContext) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  height: 600.h,
                                  padding: EdgeInsets.all(25.w),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Message"),
                                      SizedBox(
                                        height: 9.h,
                                      ),
                                      Flexible(
                                        child: SizedBox(
                                          height: 160.h,
                                          child: TextFormField(
                                            maxLines: 20,
                                            canRequestFocus: true,
                                            focusNode: messageFocus,
                                            autofocus: true,
                                            controller: messageController,
                                            keyboardType: TextInputType.text,
                                            
                                            decoration: InputDecoration(
                                                hintText: "Type Reply",
                                                border: OutlineInputBorder(
                                                    borderSide: const BorderSide(
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
                                            onPressed: () async {
                                              if (messageController
                                                  .text.isEmpty) {
                                                Flushbar(
                                                        message:
                                                            "Content is required",
                                                        flushbarPosition:
                                                            FlushbarPosition.TOP,
                                                        backgroundColor:
                                                            Colors.red,
                                                        duration: const Duration(
                                                            seconds: 2))
                                                    .show(currentContext);
                                                return;
                                              }
                              
                                              BlocProvider.of<SendMessageBloc>(
                                                      currentContext)
                                                  .add(
                                                SendMessageEvent(
                                                  await token() ?? "",
                                                  widget.ticket.token!,
                                                  messageController.text,
                                                ),
                                              );
                              
                                              Navigator.pop(currentContext);
                                              showModalBottomSheet(
                                                  context: context,
                                                  enableDrag: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  builder: (bbbb) {
                                                    Future.delayed(Duration.zero,
                                                        () {
                                                      Flushbar(
                                                              message:
                                                                  "Message Sent",
                                                              flushbarPosition:
                                                                  FlushbarPosition
                                                                      .TOP,
                                                              backgroundColor:
                                                                  Colors.green,
                                                              duration:
                                                                  const Duration(
                                                                      seconds: 2))
                                                          .show(bbbb);
                                                      convData.insert(
                                                          0,
                                                          ConversationData(
                                                              isAdmin: 0,
                                                              timeAt: 'now',
                                                              creatorName: widget
                                                                  .ticket.members
                                                                  ?.where((element) =>
                                                                      element
                                                                          .isAdmin ==
                                                                      false)
                                                                  .first
                                                                  .name,
                                                              content:
                                                                  messageController
                                                                      .text,
                                                              dateAt: "Today"));
                                                      setState(() {});
                                                      // getMessage();
                                                    });
                                                    Navigator.pop(bbbb);
                                                    return Container(
                                                      height: 200.h,
                                                      color: Colors.white,
                                                      padding:
                                                          EdgeInsets.all(25.w),
                                                      child: const Center(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircularProgressIndicator(),
                                                          Text("Sending Message")
                                                        ],
                                                      )),
                                                    );
                                                  });
                                            },
                                            child: const Text("Send"),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        widget.ticket.status == "Answered"
                            ? Colors.red
                            : Colors.blue)),
                child: Text(widget.ticket.status == "Answered"
                    ? "Ticket Closed"
                    : "Reply"),
              );
            },
          ),
        ),
      ),
      body: SizedBox(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(25.w),
              width: ScreenUtil().screenWidth,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.ticket.subject ?? "",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 11.w,
                          ),
                          SizedBox(
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
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(widget.ticket.createdAt ?? ""),
                          SizedBox(
                            width: 12.w,
                          ),
                          const Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(widget.ticket.createdAtHrm ?? ""),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        width: 200.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                                child: CustomWidget.Chip(
                                    text: widget.ticket.status ?? "",
                                    width: 48,
                                    height: 14,
                                    color: const Color(0xffE9FCE5),
                                    radius: 5.r,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                    textColor: const Color(0xff02D430))),
                            SizedBox(
                              width: 10.w,
                            ),
                            Flexible(
                                child: CustomWidget.Chip(
                                    text: widget.ticket.department ?? "",
                                    width: 48,
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
                              text: widget.ticket.service ?? "N/A",
                              width: 70,
                              height: 14,
                              fontSize: 8,
                              color: Colors.white,
                              radius: 5.r,
                              useBorder: true,
                              fontWeight: FontWeight.w500,
                              textColor: const Color(0xff232226),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svg/icons/message.svg',
                          height: 15, fit: BoxFit.fill),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        widget.ticket.conversationCount.toString(),
                        style: GoogleFonts.manrope(
                            textStyle: const TextStyle(
                                color: Color(0xff232226),
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1.5,
              color: Color(0xffF1F1F1),
              height: 0,
            ),
            Flexible(
              child: SizedBox(
                  height: ScreenUtil().screenHeight,
                  child: ListView.builder(
                      itemCount: convData.length,
                      reverse: true,
                      controller: controller,
                      itemBuilder: (context, i) {
                        return Container(
                          height: 128.h,
                          decoration: BoxDecoration(
                            color: i % 2 == 0
                                ? Colors.grey.shade100
                                : Colors.white,
                            border: const Border(
                              bottom: BorderSide(
                                  color: Color(0xffF1F1F1), width: 1.5),
                            ),
                          ),
                          padding: EdgeInsets.all(25.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: convData[i].isAdmin == 0
                                        ? Colors.blue
                                        : Colors.red,
                                    radius: 15.r,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    convData[i].creatorName ?? "",
                                    style: TextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(child: Container()),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        convData[i].dateAt ?? "",
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      const Icon(
                                        Icons.circle,
                                        size: 10,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        convData[i].timeAt ?? "",
                                        style: TextStyle(fontSize: 10.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Flexible(
                                  child: Text(
                                convData[i].content ?? "",
                                style: TextStyle(
                                    color: i % 2 == 0
                                        ? const Color.fromARGB(255, 55, 55, 55)
                                        : const Color.fromARGB(255, 55, 55, 55),
                                    fontSize: 13.sp),
                              ))
                            ],
                          ),
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
