import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hunger_games/components/dashboard/dashboard_actions.dart';
import 'package:hunger_games/components/dashboard/dashboard_activities.dart';
import 'package:hunger_games/components/dashboard/dashboard_contacts.dart';
import 'package:hunger_games/components/dashboard/dashboard_gallery.dart';
import 'package:hunger_games/components/dashboard/dashboard_map.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            DashboardActivities(),
            // DashboardActions(),
            DashboardGallery(),
            SizedBox(height: 10),
            DashboardMap(),
            DashboardContacts(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text("© League Pilot. All rights reserved."),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
