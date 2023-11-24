import 'package:dart_rfb/dart_rfb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rfb/flutter_rfb.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstanceConsoleScreen extends StatefulWidget {
  final String instanceUUID;
  const InstanceConsoleScreen({super.key, required this.instanceUUID});

  @override
  State<InstanceConsoleScreen> createState() => _InstanceConsoleScreenState();
}

class _InstanceConsoleScreenState extends State<InstanceConsoleScreen> {
  WebViewController controller = WebViewController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String windowTitle = "";
  WebViewCookieManager cookieManager = WebViewCookieManager();

  void setupWebviewController() {
    storage.read(key: 'accessToken').then((value) {
      print(value);
      // cookieManager.setCookie(WebViewCookie(name: "", value: value, domain: domain))
      controller
        ..loadRequest(
            Uri.parse(
                "https://app.maxstage.id/instances/${widget.instanceUUID}/console"),
            headers: {
              "Authorization": "Bearer $value",
              "x-mobile-token": "=U-wQEy1xn0uBgcy"
            })
        ..setJavaScriptMode(JavaScriptMode.unrestricted);

      controller.currentUrl().then((value) {
        windowTitle = windowTitle + (value ?? "user session");
        setState(() {});
      });
    });
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
          automaticallyImplyLeading: true,
          title: Text(windowTitle),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
