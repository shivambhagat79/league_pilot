import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hunger_games/components/admin/match_tile.dart';
import 'package:hunger_games/services/match_service.dart';
import 'package:hunger_games/services/tournament_service.dart';

class MatchData extends StatefulWidget {
  final String tournamentId;
  const MatchData({super.key, required this.tournamentId});

  @override
  State<MatchData> createState() => _MatchDataState();
}

class _MatchDataState extends State<MatchData> {
  final TournamentService _tournamentService = TournamentService();
  final MatchService _matchService = MatchService();
  List<String> _filters = [];
  Stream<QuerySnapshot<Map<String, dynamic>>> _matchStream = Stream.empty();
  bool _isLoading = false;
  String _selectedFilter = 'All';

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final List<String> sports =
        await _tournamentService.getSports(widget.tournamentId);

    final Stream<QuerySnapshot<Map<String, dynamic>>> matchStream =
        _matchService.getMatchesForTournament(widget.tournamentId);

    setState(() {
      _filters = ['All', ...sports];
      _isLoading = false;
      _matchStream = matchStream;
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LinearProgressIndicator()
        : Column(
            children: [
              Text(
                'Matches',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Overcame',
                  color: Colors.grey.shade700,
                  letterSpacing: 2,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  children: _filters
                      .map(
                        (filter) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: FilterChip(
                            label: Text(filter),
                            onSelected: (value) {
                              setState(() {
                                _selectedFilter = filter;
                              });
                            },
                            selected: _selectedFilter == filter,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                  stream: _matchStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    final filteredDocs = snapshot.data!.docs.where((doc) {
                      Map<String, dynamic> match =
                          doc.data() as Map<String, dynamic>;

                      if (_selectedFilter == "All") return true;

                      if (_selectedFilter == match["sport"]) return true;

                      return false;
                    });

                    if (filteredDocs.isEmpty) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child:
                            Text("No matches available for the selected sport"),
                      );
                    }

                    return Column(
                      children: filteredDocs.map((DocumentSnapshot document) {
                        Map<String, dynamic> match =
                            document.data() as Map<String, dynamic>;
                        String id = document.id;
                        return MatchTile(match: match, matchId: id);
                      }).toList(),
                    );
                  }),
              SizedBox(height: 60),
            ],
          );
  }
}
