import 'package:flutter/material.dart';
import 'package:hunger_games/components/teams/sport_details.dart';

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


class SportCard extends StatefulWidget {
  final String sportName;

  const SportCard({
    super.key,
    required this.sportName,
  });

  @override
  _SportCardState createState() => _SportCardState();
}

class _SportCardState extends State<SportCard> {

  void _navigateToSportDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SportDetails(
          sportName: widget.sportName, // Pass team logo
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.teal, width: 2), // Border color & thickness
          borderRadius: BorderRadius.circular(12), // Optional: Rounded corners
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(
                sportsIcons[widget.sportName] ?? Icons.sports, // Image passed dynamically
                color: Colors.blue,
                size: 30,
              ),
              title: Text(widget.sportName),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('SEE BIO'),
                  onPressed: _navigateToSportDetails,
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
