import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/teams/sports_teams.dart';
import 'package:hunger_games/services/tournament_service.dart';

class Teams extends StatefulWidget {
  final String tournamentId;
  const Teams({super.key, required this.tournamentId});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  final TournamentService _tournamentService = TournamentService();
  bool _isLoading = false;
  late List<String> _contingents;
  late List<String> _sports;

  Future<void> _fetchContingents() async {
    setState(() {
      _isLoading = true;
    });

    List<String> contingents =
        await _tournamentService.getContingents(widget.tournamentId);
    List<String> sports =
        await _tournamentService.getSports(widget.tournamentId);

    setState(() {
      _contingents = contingents;
      _sports = sports;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchContingents();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LinearProgressIndicator()
        : Customscrollpage(
            title: "Contingents",
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _contingents.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          leading:
                              const Icon(Icons.emoji_events_outlined, size: 30),
                          title: Text(
                            _contingents[index],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SportTeams(
                                  tournamentId: widget.tournamentId,
                                  contingent: _contingents[index],
                                  sports: _sports,
                                ),
                              ),
                            );
                          },
                        ),
                        Divider(height: 0),
                      ],
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("© League Pilot. All rights reserved."),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
  }
}
