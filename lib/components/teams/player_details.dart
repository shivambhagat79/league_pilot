import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';

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

class PlayerDetails extends StatefulWidget {
  final String name;
  final String photoUrl;
  final String email;
  final String phoneNumber;
  final String tournamentContingent;
  final String title; // Team name

  const PlayerDetails({
    super.key,
    required this.name,
    this.photoUrl = "assets/images/components/Sample_User_Icon.png",
    required this.email,
    required this.phoneNumber,
    required this.tournamentContingent,
    this.title = "",
  });

  @override
  State<PlayerDetails> createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "PLAYER INFO",
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // Team Logo
            Image.asset(
              widget.photoUrl, // Image passed dynamically
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
              widget.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            Text(
              widget.tournamentContingent,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.teal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.email,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.teal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              widget.phoneNumber,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.teal,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),



            // Team Description

          ],
        ),


      ),
    );
  }
}

