import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/teams/player_card.dart';

Map<String, IconData> sportsIcons = {
  "Soccer": Icons.sports_soccer,
  "Basketball": Icons.sports_basketball,
  "Football": Icons.sports_football,
  "Baseball": Icons.sports_baseball,
  "Tennis": Icons.sports_tennis,
  "Cricket": Icons.sports_cricket,
  "Volleyball": Icons.sports_volleyball,
  "Hockey": Icons.sports_hockey,
  "Archery": Icons.sports,
  "Cycling": Icons.directions_bike,
};

class SportDetails extends StatefulWidget {
  final String sportName; // Team name

  const SportDetails({
    super.key,
    required this.sportName,
  });

  @override
  State<SportDetails> createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<SportDetails> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "SPORT INFO",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // Team Logo
            Icon(
              sportsIcons[widget.sportName] ?? Icons.sports, // Image passed dynamically
              color: Colors.blue,
              size: 30,
            ),
            const SizedBox(height: 20), // Space between logo and text

            // Team Name
            Text(
              widget.sportName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            PlayerCard(
              name: "Ishaan Sharma",
              email: "2022eeb1173@iitrpr.ac.in",
              phoneNumber: "8368129851",
              tournamentContingent: "IIT Ropar",
            ),
            // Team Description

          ],
        ),


      ),
    );
  }
}

