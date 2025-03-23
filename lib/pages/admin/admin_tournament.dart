import 'package:flutter/material.dart';
import 'package:hunger_games/components/admin/match_data.dart';
import 'package:hunger_games/components/admin/sports_data.dart';
import 'package:hunger_games/components/admin/tournament_data.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/admin/create_match.dart';
import 'package:hunger_games/services/tournament_service.dart';

class AdminTourrnamentPage extends StatefulWidget {
  final String title;
  final String tournamentId;
  const AdminTourrnamentPage(
      {super.key, required this.title, required this.tournamentId});

  @override
  State<AdminTourrnamentPage> createState() => _AdminTourrnamentPageState();
}

class _AdminTourrnamentPageState extends State<AdminTourrnamentPage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;
  final List<String> _remainingSports = [
    "Football",
    "Cricket",
    "Basketball",
    "Lawn Tennis",
    "Badminton",
    "Volleyball",
    "Hockey",
    "Chess"
  ];
  List<String> _tournamentSports = [];
  final TournamentService _tournamentService = TournamentService();
  String? _selectedSport;

  Future<void> _getTournamentSports() async {
    List<String> sports =
        await _tournamentService.getSports(widget.tournamentId);
    setState(() {
      _tournamentSports = sports;
      _remainingSports
          .removeWhere((element) => _tournamentSports.contains(element));
    });
  }

  @override
  void initState() {
    super.initState();
    _pages = [
      MatchData(tournamentId: widget.tournamentId),
      SportsData(tournamentId: widget.tournamentId),
      TournamentData(tournamentId: widget.tournamentId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: widget.title,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.sports_cricket),
            label: 'Match Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports),
            label: 'Sport Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events),
            label: 'Tournament Data',
          ),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateMatchPage(
                      tournamentId: widget.tournamentId,
                    ),
                  ),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              label: Text('Add Match'),
              icon: Icon(Icons.add),
            )
          : _selectedIndex == 1
              ? FloatingActionButton.extended(
                  onPressed: () async {
                    await _getTournamentSports();
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('Add Sport'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      'Select a sport to add to the tournament:'),
                                  SizedBox(height: 20),
                                  DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Sport',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    value: _selectedSport,
                                    items: _remainingSports.map((sport) {
                                      return DropdownMenuItem(
                                        value: sport,
                                        child: Text(sport),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) async {
                                      setState(() {
                                        _selectedSport = newValue;
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Please select a tournamnet'
                                        : null,
                                  ),
                                ],
                              ),
                              actions: [
                                FilledButton(
                                  onPressed: () {},
                                  child: Text('Add'),
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                              ],
                            ));
                  },
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  label: Text('Add Sport'),
                  icon: Icon(Icons.add),
                )
              : null,
      child: _pages[_selectedIndex],
    );
  }
}
