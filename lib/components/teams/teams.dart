import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/teams/team_card.dart';

class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Teams",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TeamCard(
              teamName: "IIT Ropar",
              logoUrl: "assets/images/components/iit-ropar.jpg",
              description: "A competitive and passionate team from IIT Ropar.",
            ),
            const SizedBox(height: 10),
            TeamCard(
              teamName: "IIT Kanpur",
              logoUrl: "assets/images/components/iit-kanpur.jpg",
              description:
                  "A well-experienced and skilled team from IIT Kanpur.",
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  "© League Pilot. All rights reserved.",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
