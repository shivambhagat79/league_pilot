import 'package:flutter/material.dart';
import 'package:hunger_games/components/teams/player_details.dart';

class PlayerCard extends StatefulWidget {
  final String name;
  final String photoUrl;
  final String email;
  final String phoneNumber;
  final String tournamentContingent;
  final String title;

  const PlayerCard({
    super.key,
    required this.name,
    this.photoUrl = "assets/images/components/Sample_User_Icon.png",
    required this.email,
    required this.phoneNumber,
    required this.tournamentContingent,
    this.title = "",
  });

  @override
  _PlayerCardState createState() => _PlayerCardState();
}

class _PlayerCardState extends State<PlayerCard> {
  void _navigateToPlayerDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayerDetails(
          name: widget.name,
          photoUrl: widget.photoUrl, // Pass team logo
          email: widget.email,
          phoneNumber: widget.phoneNumber,
          tournamentContingent: widget.tournamentContingent,
          title: widget.title// Pass team description
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
              leading: Image.asset(widget.photoUrl),
              title: Text(widget.title.isNotEmpty ? widget.title : widget.name),
              subtitle: widget.title.isNotEmpty ? Text(widget.name) : null, // Remove subtitle if title is empty
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('SEE BIO'),
                  onPressed: _navigateToPlayerDetails,
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