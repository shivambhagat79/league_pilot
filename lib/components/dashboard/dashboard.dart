import 'package:flutter/material.dart';
import 'package:hunger_games/components/dashboard/dashboard_actions.dart';
import 'package:hunger_games/components/dashboard/dashboard_activities.dart';
import 'package:hunger_games/components/dashboard/dashboard_gallery.dart';

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
        child: Column(
          children: [
            DashboardActivities(),
            DashboardActions(),
            DashboardGallery(),
          ],
        ),
      ),
    );
  }
}
