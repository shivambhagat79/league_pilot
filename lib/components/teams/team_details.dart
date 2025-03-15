import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/teams/player_card.dart';
import 'package:hunger_games/components/teams/sport_card.dart';

class TeamDetails extends StatefulWidget {
  final String teamName; // Team name
  final String logoUrl; // Team logo URL
  final String description; // Team description

  const TeamDetails({
    super.key,
    required this.teamName,
    required this.logoUrl,
    required this.description,
  });

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "TEAM INFO",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // Team Logo
            Image.asset(
              widget.logoUrl, // Image passed dynamically
              width: 120, // Adjust size as needed
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported,
                  size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 20), // Space between logo and text

            // Team Name
            Text(
              widget.teamName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Team Description
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.teal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            const SizedBox(height: 10),

            PlayerCard(
                name: "Ishaan Sharma",
                email: "2022eeb1173@iitrpr.ac.in",
                phoneNumber: "8368129851",
                tournamentContingent: "IIT Ropar",
                title: "Contingent Leader",
            ),

            SportCard(sportName: "Cricket"),
            SportCard(sportName: "Basketball"),
            SportCard(sportName: "Football"),
            SportCard(sportName: "Soccer"),
            SportCard(sportName: "Baseball"),
            SportCard(sportName: "Tennis"),
            SportCard(sportName: "Volleyball"),
            SportCard(sportName: "Hockey"),
            SportCard(sportName: "Archery"),
            SportCard(sportName: "Cycling"),

          ],
        ),


      ),
    );
  }
}

