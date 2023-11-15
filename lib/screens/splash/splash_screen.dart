import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maxcloud/screens/auth/login-screen.dart';
import 'package:maxcloud/screens/navbar.component.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String> getAccessToken() async {
    return await storage.read(key: 'accessToken') ?? "";
  }

  @override
  void initState() {
    /**TODO: Change navigation to auth first or if you have alredy created auth function please do check if users have session then push the user into home screen else push the user into auth screen
     *
     */
    Future.delayed(const Duration(seconds: 3), () async {
      if (await getAccessToken() == "") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
        return;
      }

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const NavbarComponent()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/images/splashscreen.jpg"),
      fit: BoxFit.cover,
    );
  }
}
