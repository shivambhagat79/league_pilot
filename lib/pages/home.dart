import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hunger_games/components/dashboard/dashboard.dart';
import 'package:hunger_games/components/matches/matches.dart';
import 'package:hunger_games/components/results/results.dart';
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
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            ColorScheme.fromSeed(seedColor: Colors.teal).surfaceContainer,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  int currentPageIndex = 0;

  final List<Widget> pages = <Widget>[
    const Dashboard(),
    const Matches(),
    const Teams(),
    const Results(),
    const Schedule(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.sports_cricket_outlined),
              selectedIcon: Icon(Icons.sports_cricket),
              label: 'Matches',
            ),
            NavigationDestination(
              icon: Icon(Icons.group_outlined),
              selectedIcon: Icon(Icons.group),
              label: 'Teams',
            ),
            NavigationDestination(
              icon: Icon(Icons.scoreboard_outlined),
              selectedIcon: Icon(Icons.scoreboard),
              label: 'Results',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Schedule',
            ),
          ],
        ),
      ),
    );
  }
}
