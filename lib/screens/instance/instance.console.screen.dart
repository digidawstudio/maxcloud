import 'package:dart_rfb/dart_rfb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rfb/flutter_rfb.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstanceConsoleScreen extends StatefulWidget {
  final Map<String, dynamic> consoleData;
  const InstanceConsoleScreen({super.key, required this.consoleData});

  @override
  State<InstanceConsoleScreen> createState() => _InstanceConsoleScreenState();
}

class _InstanceConsoleScreenState extends State<InstanceConsoleScreen> {
  WebViewController controller = WebViewController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String windowTitle = "";
  WebViewCookieManager cookieManager = WebViewCookieManager();
  bool isLoading = false;

  void setupWebviewController() {
    String websocketUrl = widget.consoleData["url"];
    String x11 = Uri.encodeFull(widget.consoleData["password"]);

    storage.read(key: 'accessToken').then((value) {
      print(value);
      // cookieManager.setCookie(WebViewCookie(name: "", value: value, domain: domain))
      controller
        ..loadRequest(
          Uri.parse(
              "https://api.maxstage.id/mobile/console?wsurl=$websocketUrl&wspass=$x11"),
        )
        ..setNavigationDelegate(NavigationDelegate(onProgress: (progress) {
          isLoading = true;
          setState(() {});
        }, onPageFinished: (url) {
          isLoading = false;
          setState(() {});
        }))
        ..setJavaScriptMode(JavaScriptMode.unrestricted);

      controller.currentUrl().then((value) {
        print(value);
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
        body: isLoading
            ? Container(
                height: ScreenUtil().screenHeight,
                width: ScreenUtil().screenWidth,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : WebViewWidget(
                controller: controller,
              ));
  }
}
