import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maxcloud/bloc/navigation/navigation.bloc.dart';
import 'package:maxcloud/screens/billing/billing.screen.dart';
import 'package:maxcloud/screens/instance/instance.screen.dart';
import 'package:maxcloud/screens/help/helpdesk.screen.dart';
import 'package:maxcloud/screens/profile/profile.screen.dart';

import 'home/home.screen.dart';

class NavbarComponent extends StatefulWidget {
  const NavbarComponent({super.key});

  @override
  State<NavbarComponent> createState() => _NavbarComponentState();
}

class _NavbarComponentState extends State<NavbarComponent> {
  late int currentIndex = 0;
  List<Widget> body = [
    const HomeScreen(),
    const InstanceScreen(),
    const BillingScreen(),
    const HelpDeskScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
            builder: (context, state) {
          if (state is InitialNavigationState) {
            WidgetsBinding.instance
                .addPostFrameCallback((timeStamp) => setState(() {
                      currentIndex = state.index;
                    }));
          }
          if (state is LoadedNavigationState) {
            WidgetsBinding.instance
                .addPostFrameCallback((timeStamp) => setState(() {
                      currentIndex = state.index;
                    }));
          }

          return CupertinoTabBar(
            height: 70.h,
            backgroundColor: const Color(0xff009EFF),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/svg/nav-icons/inactive/home-inactive.svg',
                      height: 20,
                      fit: BoxFit.scaleDown),
                  activeIcon: SvgPicture.asset(
                      'assets/svg/nav-icons/active/home.svg',
                      height: 20,
                      fit: BoxFit.scaleDown)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/svg/nav-icons/inactive/instance-inactive.svg',
                      height: 28,
                      fit: BoxFit.scaleDown),
                  activeIcon: SvgPicture.asset(
                      'assets/svg/nav-icons/active/instance.svg',
                      height: 28,
                      fit: BoxFit.scaleDown)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/svg/nav-icons/inactive/billing-inactive.svg',
                      height: 28,
                      fit: BoxFit.scaleDown),
                  activeIcon: SvgPicture.asset(
                      'assets/svg/nav-icons/active/billing.svg',
                      height: 28,
                      fit: BoxFit.scaleDown)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/svg/nav-icons/inactive/help-inactive.svg',
                      height: 28,
                      fit: BoxFit.scaleDown),
                  activeIcon: SvgPicture.asset(
                      'assets/svg/nav-icons/active/help.svg',
                      height: 28,
                      fit: BoxFit.scaleDown)),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                      'assets/svg/nav-icons/inactive/profile-inactive.svg',
                      height: 28,
                      fit: BoxFit.scaleDown),
                  activeIcon: SvgPicture.asset(
                      'assets/svg/nav-icons/active/profile.svg',
                      height: 28,
                      fit: BoxFit.scaleDown)),
            ],
            currentIndex: currentIndex,
            onTap: (index) {
              BlocProvider.of<NavigationBloc>(context)
                  .add(SetNavigatorIndexEvent(index));
            },
          );
        }),
        body: body[currentIndex],
      ),
    );
  }
}
