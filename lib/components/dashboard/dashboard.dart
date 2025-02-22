import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/heading_cut_card.dart';

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
              tail: Container(),
              child: Container(
                height: 200,
                // color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
