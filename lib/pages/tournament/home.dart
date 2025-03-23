import 'package:flutter/material.dart';

import 'package:hunger_games/components/common/floating_bottom_nav_bar.dart';
import 'package:hunger_games/components/dashboard/dashboard.dart';
import 'package:hunger_games/components/matches/matches.dart';
import 'package:hunger_games/components/points_table/points_table.dart';
import 'package:hunger_games/components/teams/teams.dart';

class HomePage extends StatefulWidget {
  final String tournamentId;
  const HomePage({super.key, required this.tournamentId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  late List<Widget> pages;

  void onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  void initState() {
    pages = <Widget>[
      const Dashboard(),
      Matches(tournamentId: widget.tournamentId),
      const PointsTable(),
      const Teams(),
    ];
    super.initState();
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
              child: FloatingBottomNavBar(
                  onDestinationSelected: onDestinationSelected))
        ],
      ),
    );
  }
}
