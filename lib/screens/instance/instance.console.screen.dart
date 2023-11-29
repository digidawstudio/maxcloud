import 'package:dart_rfb/dart_rfb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rfb/flutter_rfb.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstanceConsoleScreen extends StatefulWidget {
  final String url;
  const InstanceConsoleScreen({super.key, required this.url});

  @override
  State<InstanceConsoleScreen> createState() => _InstanceConsoleScreenState();
}

class _InstanceConsoleScreenState extends State<InstanceConsoleScreen> {
  WebViewController controller = WebViewController();

  void setupWebviewController() {
    print(widget.url);
    // cookieManager.setCookie(WebViewCookie(name: "", value: value, domain: domain))
    controller
      ..loadRequest(
        Uri.parse(widget.url),
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    controller.setNavigationDelegate(
      NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://app.maxstage.id/login')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  @override
  void initState() {
    setupWebviewController();
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
              Text("Console",
                  style: GoogleFonts.manrope(
                      textStyle: const TextStyle(
                          color: Color(0xff353333),
                          fontSize: 25,
                          fontWeight: FontWeight.w600))),
            ],
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: SvgPicture.asset('assets/svg/icons/ios-back.svg',
                height: 24, fit: BoxFit.scaleDown),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
