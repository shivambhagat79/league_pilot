import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/matches/cards.dart';
import 'package:hunger_games/components/matches/tab.dart';
import 'package:hunger_games/services/match_service.dart';

class Matches extends StatefulWidget {
  final String tournamentId;
  const Matches({super.key, required this.tournamentId});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  final MatchService _matchService = MatchService();
  Stream<QuerySnapshot<Map<String, dynamic>>> _matchStream = Stream.empty();
  bool _isLoading = false;

  String _selectedTab = "live"; // Default category
  String _selectedSport = "All"; // Default sport selection (new "All" tab)

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final Stream<QuerySnapshot<Map<String, dynamic>>> matchStream =
        _matchService.getMatchesForTournament(widget.tournamentId);

    setState(() {
      _matchStream = matchStream;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Matches",
      child: _isLoading
          ? LinearProgressIndicator()
          : Column(
              children: [
                TabButtons(
                  tournamentId: widget.tournamentId,
                  selectedTab: _selectedTab,
                  selectedSport: _selectedSport,
                  onTabChange: (String newTab) {
                    setState(() {
                      _selectedTab = newTab;
                      _selectedSport = "All";
                    });
                  },
                  onSportChange: (String newSport) {
                    setState(() {
                      _selectedSport = newSport;
                    });
                  },
                ),

                StreamBuilder(
                  stream: _matchStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    final filteredDocs = snapshot.data!.docs.where((doc) {
                      Map<String, dynamic> match = doc.data();

                      bool statusMatch = match["status"] == _selectedTab;
                      bool sportMatch = _selectedSport == "All" ||
                          _selectedSport == match["sport"];

                      return statusMatch && sportMatch;
                    });

                    if (filteredDocs.isEmpty) {
                      return Container(
                        height: 500,
                        alignment: Alignment.center,
                        child: Text(
                          "No Matches to Display.",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: filteredDocs.map((doc) {
                        Map<String, dynamic> match = doc.data();

                        if (match['status'] == 'live') {
                          return LiveNowCard(match: match);
                        } else if (match['status'] == 'upcoming') {
                          return UpcomingCard(match: match);
                        } else {
                          return ResultsCard(match: match);
                        }
                      }).toList(),
                    );
                  },
                ),

                // Footer
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("© League Pilot. All rights reserved."),
                ),
                SizedBox(height: 80),
              ],
            ),
    );
  }
}
