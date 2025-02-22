import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hunger_games/components/common/floating_bottom_nav_bar.dart';
import 'package:hunger_games/components/dashboard/dashboard.dart';
import 'package:hunger_games/components/matches/matches.dart';
import 'package:hunger_games/components/points_table/points_table.dart';
import 'package:hunger_games/components/schedule/schedule.dart';
import 'package:hunger_games/components/teams/teams.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark));
  }

  int currentPageIndex = 0;

  final List<Widget> pages = <Widget>[
    const Dashboard(),
    const Matches(),
    const PointsTable(),
    const Schedule(),
    const Teams(),
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
      body: pages[currentPageIndex],
      bottomNavigationBar: FloatingBottomNavBar(
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
