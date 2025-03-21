import 'package:flutter/material.dart';
import 'package:hunger_games/components/teams/team_details.dart';

class TeamCard extends StatefulWidget {
  final String teamName;
  final String logoUrl;
  final String description;

  const TeamCard({
    super.key,
    required this.teamName,
    this.logoUrl = "assets/images/components/Sample_Team_Icon.jpg",
    required this.description,
  });

  @override
  _TeamCardState createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {

  // void _navigateToTeamDetails() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => TeamDetails(
  //           teamName: widget.teamName,
  //           logoUrl: widget.logoUrl, // Pass team logo
  //           description: widget.description, // Pass team description
  //       ),
  //     ),
  //   );
  // }

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
              leading: Image.asset(
                  widget.logoUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
              ),
              title: Text(widget.teamName),
              subtitle: Text(widget.description),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('SEE BIO'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TeamDetails(
                          teamName: widget.teamName,
                          logoUrl: widget.logoUrl, // Pass team logo
                          description: widget.description, // Pass team description
                        ),
                      ),
                    );
                  },
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
