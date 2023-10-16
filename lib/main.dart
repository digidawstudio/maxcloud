import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxcloud/bloc/auth/auth.bloc.dart';
import 'package:maxcloud/bloc/product/product.bloc.dart';
import 'package:maxcloud/bloc/user/user.bloc.dart';
import 'package:maxcloud/screens/auth/login-screen.dart';
import 'package:maxcloud/screens/splash/splash_screen.dart';
import 'package:maxcloud/screens/users/user-screen.dart';
import 'package:maxcloud/utils/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => UserBloc()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (_, child) {
        return MaterialApp(
            title: Constants.appname,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: child);
      },
      child: SplashScreen(),
    );
  }
}
