import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/scorekeeper/scorekeeper_match_tile.dart';
import 'package:hunger_games/services/match_service.dart';
import 'package:hunger_games/services/shared_preferences.dart';
// import 'package:hunger_games/services/tournament_service.dart';

class ScorekeeperPage extends StatefulWidget {
  const ScorekeeperPage({super.key});

  @override
  State<ScorekeeperPage> createState() => _ScorekeeperPageState();
}

class _ScorekeeperPageState extends State<ScorekeeperPage> {
  // final TournamentService _tournamentService = TournamentService();
  final MatchService _matchService = MatchService();
  final List<String> _filters = [
    'All',
    'Football',
    'Cricket',
    'Basketball',
    'Lawn Tennis',
    'Badminton',
    'Volleyball',
    'Hockey',
    'Chess',
  ];
  Stream<QuerySnapshot<Map<String, dynamic>>> _matchStream = Stream.empty();
  bool _isLoading = false;
  String _selectedFilter = 'All';

  Future<void> _getMatchStream() async {
    setState(() {
      _isLoading = true;
    });

    String email = await getAdminEmail() ?? "";

    Stream<QuerySnapshot<Map<String, dynamic>>> matchStream =
        _matchService.getMatchesForScorekeeper(email);

    setState(() {
      _matchStream = matchStream;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getMatchStream();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: 'Your Matches',
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Logout?'),
              content: Text('Are you sure you want to logout?'),
              actions: [
                FilledButton(
                  onPressed: () async {
                    await saveAdminLoginState(false);
                    await saveAdminEmail('');
                    await saveAdminId('');
                    await saveAdminType('');
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'),
                ),
              ],
            ),
          ),
        ),
      ],
      child: _isLoading
          ? LinearProgressIndicator()
          : Column(
              children: [
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
                          child: Text(
                              "No matches available for the selected sport"),
                        );
                      }

                      return Column(
                        children: filteredDocs.map((DocumentSnapshot document) {
                          Map<String, dynamic> match =
                              document.data() as Map<String, dynamic>;
                          String id = document.id;
                          return ScorekeeperMatchTile(
                              match: match, matchId: id);
                        }).toList(),
                      );
                    }),
                SizedBox(height: 60),
              ],
            ),
    );
  }
}
