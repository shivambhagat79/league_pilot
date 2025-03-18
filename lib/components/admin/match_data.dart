import 'package:flutter/material.dart';
import 'package:hunger_games/components/admin/match_tile.dart';
import 'package:hunger_games/components/matches/sample_data.dart';
import 'package:hunger_games/services/tournament_service.dart';

class MatchData extends StatefulWidget {
  final String tournamentId;
  const MatchData({super.key, required this.tournamentId});

  @override
  State<MatchData> createState() => _MatchDataState();
}

class _MatchDataState extends State<MatchData> {
  final TournamentService _tournamentService = TournamentService();
  List<String> _filters = [];
  bool _isLoading = false;
  String _selectedFilter = 'All';

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    final List<String> sports =
        await _tournamentService.getSports(widget.tournamentId);

    setState(() {
      _filters = ['All', ...sports];
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
              Column(
                children: matchData.where((e) {
                  if (_selectedFilter == 'All') {
                    return true;
                  }
                  return e['sport'] == _selectedFilter;
                }).map((match) {
                  return MatchTile(match: match);
                }).toList(),
              ),
              SizedBox(height: 60),
            ],
          );
  }
}
