import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:maxcloud/bloc/product/product.bloc.dart';
import 'package:maxcloud/bloc/user/user.bloc.dart';
import 'package:maxcloud/screens/splash/splash_screen.dart';
import 'package:maxcloud/screens/users/user-screen.dart';
import 'package:maxcloud/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Constants.appname,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => UserBloc()),
            BlocProvider(create: (context) => ProductBloc())
          ], child: SplashScreen(),));
  }
}
