import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maxcloud/screens/profile/profile.screen.dart';

import 'home/home.screen.dart';

class NavbarComponent extends StatefulWidget {
  const NavbarComponent({super.key});

  @override
  State<NavbarComponent> createState() => _NavbarComponentState();
}

class _NavbarComponentState extends State<NavbarComponent> {
  int currentIndex = 0;
  List<Widget> body = [
    HomeScreen(),
    Container(),
    Container(),
    Container(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Color(0xff009EFF),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey[300],
              ),
              activeIcon: Icon(
                Icons.home_filled,
                color: Colors.white,
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.computer_outlined,
              color: Colors.grey[300],
            ),
            activeIcon: Icon(
              Icons.computer,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wallet_outlined,
              color: Colors.grey[300],
            ),
            activeIcon: Icon(
              Icons.wallet,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline_rounded, color: Colors.grey[300]),
            activeIcon: Icon(
              Icons.help_rounded,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_rounded,
                color: Colors.grey[300],
              ),
              activeIcon: Icon(
                Icons.person_rounded,
                color: Colors.white,
              )),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: body[currentIndex],
    );
  }
}
