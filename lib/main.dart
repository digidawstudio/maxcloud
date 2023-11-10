import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maxcloud/bloc/auth/auth.bloc.dart';
import 'package:maxcloud/bloc/billing/create-invoice.bloc.dart';
import 'package:maxcloud/bloc/billing/deposit-history.bloc.dart';
import 'package:maxcloud/bloc/billing/month-summary.bloc.dart';
import 'package:maxcloud/bloc/billing/payment-method.bloc.dart';
import 'package:maxcloud/bloc/notifications/notifications.bloc.dart';
import 'package:maxcloud/bloc/product/product.bloc.dart';
import 'package:maxcloud/bloc/product/rrd-data.bloc.dart';
import 'package:maxcloud/bloc/product/total-resource.bloc.dart';
import 'package:maxcloud/bloc/product/vm-detail.bloc.dart';
import 'package:maxcloud/bloc/product/vm-state.bloc.dart';
import 'package:maxcloud/bloc/profile/change-password.bloc.dart';
import 'package:maxcloud/bloc/profile/profile.bloc.dart';
import 'package:maxcloud/bloc/user/user.bloc.dart';
import 'package:maxcloud/screens/auth/login-screen.dart';
import 'package:maxcloud/screens/splash/splash_screen.dart';
import 'package:maxcloud/utils/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/product/latest-vm.bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(create: (context) => RRDDataBloc()),
      BlocProvider(create: (context) => NotificationBloc()),
      BlocProvider(create: (context) => PaymentMethodBloc()),
      BlocProvider(create: (context) => DepositHistoryBloc()),
      BlocProvider(create: (context) => ChangePasswordBloc()),
      BlocProvider(create: (context) => CreateInvoiceBloc()),
      BlocProvider(create: (context) => VMDetailBloc()),
      BlocProvider(create: (context) => LatestVMBloc()),
      BlocProvider(create: (context) => TotalResourceBloc()),
      BlocProvider(create: (context) => MonthSummaryBloc()),
      BlocProvider(create: (context) => ProfileBloc()),
      BlocProvider(create: (context) => UserBloc()),
      BlocProvider(create: (context) => ProductBloc()),
      BlocProvider(create: (context) => UpdateUserBloc()),
      BlocProvider(create: (context) => VMStateBloc()),
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
