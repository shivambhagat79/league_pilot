import 'package:flutter/material.dart';
import 'package:hunger_games/components/dashboard/dashboard_actions.dart';
import 'package:hunger_games/components/dashboard/dashboard_activities.dart';
import 'package:hunger_games/components/dashboard/dashboard_gallery.dart';
import 'package:hunger_games/components/dashboard/dashboard_map.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            DashboardActivities(),
            DashboardActions(),
            DashboardGallery(),
            SizedBox(height: 10),
            DashboardMap(),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
