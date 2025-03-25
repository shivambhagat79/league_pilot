import 'package:flutter/material.dart';
import 'package:hunger_games/pages/admin/sport.dart';
import 'package:hunger_games/services/tournament_service.dart';
import 'package:hunger_games/utils/sport_to_icon.dart';

class SportsData extends StatefulWidget {
  final String tournamentId;
  const SportsData({super.key, required this.tournamentId});

  @override
  State<SportsData> createState() => _SportsDataState();
}

class _SportsDataState extends State<SportsData> {
  late List<String> _sports;
  final TournamentService _tournamentService = TournamentService();
  bool _isLoading = false;

  Future<void> _fetchSports() async {
    setState(() {
      _isLoading = true;
    });

    final List<String> sports =
        await _tournamentService.getSports(widget.tournamentId);

    setState(() {
      _sports = sports;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _fetchSports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? LinearProgressIndicator()
        : Column(
            children: _sports
                .map(
                  (sport) => Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SportPage(
                                sport: sport,
                                tournamentId: widget.tournamentId,
                              ),
                            ),
                          );
                        },
                        title: Row(
                          children: [
                            Icon(sportToIcon[sport]),
                            SizedBox(width: 20),
                            Text(sport),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Delete Sport'),
                                      content: Text(
                                          'Are you sure you want to delete this sport?'),
                                      actions: [
                                        FilledButton(
                                          onPressed: () async {
                                            await _tournamentService
                                                .removeSportFromTournament(
                                                    widget.tournamentId, sport);
                                            _fetchSports();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete)),
                      ),
                      Divider(height: 0, thickness: 1),
                    ],
                  ),
                )
                .toList(),
          );
  }
}
