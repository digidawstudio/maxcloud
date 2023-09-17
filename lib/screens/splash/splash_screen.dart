import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    /**TODO: Change navigation to auth first or if you have alredy created auth function please do check if users have session then push the user into home screen else push the user into auth screen
     *
     */
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Container()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage("assets/images/splashscreen.jpg"), fit: BoxFit.cover,);
  }
}
