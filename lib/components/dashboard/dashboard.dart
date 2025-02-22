import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/heading_cut_card.dart';
import 'package:hunger_games/components/dashboard/dashboard_actions.dart';

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
            HeadingCutCard(
              heading: "DASHBOARD",
              tail: Container(
                margin: EdgeInsets.only(top: 6),
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Text(
                  "RECENT ACTIVITY",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontFamily: "Overcame",
                    fontSize: 18,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
              ),
              child: Container(
                height: 200,
                // color: Colors.white,
              ),
            ),
            DashboardActions(),
          ],
        ),
      ),
    );
  }
}
