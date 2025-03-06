import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/nav_bar_login.dart';
import 'package:hunger_games/components/logincr/Login.dart';
import 'package:hunger_games/components/logincr/Register.dart';


class navi extends StatefulWidget {
  const navi({super.key});

  @override
  State<navi> createState() => _naviState();
}

class _naviState extends State<navi> {
  int currentPageIndex = 0;

  final List<Widget> pages = <Widget>[
    const loginPage(),
    const register(),
  ];

  void onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          pages[currentPageIndex],
          Align(
              alignment: Alignment.bottomCenter,
              child: navBar(
                  onDestinationSelected: onDestinationSelected))
        ],
      ),
    );
  }
}
