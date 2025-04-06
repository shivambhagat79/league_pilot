import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/teams/players.dart';
import 'package:hunger_games/utils/sport_to_icon.dart';

class SportTeams extends StatefulWidget {
  final String tournamentId;
  final String contingent;
  final List<String> sports;
  const SportTeams(
      {super.key,
      required this.tournamentId,
      required this.contingent,
      required this.sports});

  @override
  State<SportTeams> createState() => _SportTeamsState();
}

class _SportTeamsState extends State<SportTeams> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: widget.contingent,
      child: Column(
        children: <Widget>[
              Text(
                "Teams",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Overcame",
                    letterSpacing: 5,
                    color: Colors.black54),
              ),
            ] +
            widget.sports.map((sport) {
              return Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    title: Text(sport),
                    leading: Icon(sportToIcon[sport]),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Players(
                            tournamentId: widget.tournamentId,
                            contingent: widget.contingent,
                            sport: sport,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 0),
                ],
              );
            }).toList(),
      ),
    );
  }
}
