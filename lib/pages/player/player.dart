import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/pages/player/create_team.dart';
import 'package:hunger_games/pages/tournament/tournaments.dart';
import 'package:hunger_games/services/player_service.dart';
import 'package:hunger_games/services/shared_preferences.dart';

class PlayerPage extends StatefulWidget {
  final String playerEmail;
  const PlayerPage({super.key, required this.playerEmail});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final PlayerService _playerService = PlayerService();
  late Map<String, dynamic> playerData;
  final TextStyle _fieldTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final TextStyle _valueTextStyle = TextStyle(fontSize: 16);
  bool _isLoading = false;

  Future<void> _fetchPlayerData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> data =
        await _playerService.getPlayer(widget.playerEmail);

    setState(() {
      playerData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPlayerData();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Player Portal",
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
                    await savePlayerLoginState(false);
                    await savePlayerId('');
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CreateTeamPage(
                tournament: playerData['tournament'],
                contingent: playerData['tournamentContingent'],
              ),
            ),
          );
        },
        label: Text('Create Team'),
        icon: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
      ),
      child: _isLoading
          ? LinearProgressIndicator()
          : Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Your Info",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Overcame",
                      letterSpacing: 5,
                      color: Colors.black54),
                ),
                SizedBox(height: 60),
                SizedBox(
                  width: double.maxFinite,
                  child: DataTable(
                    headingRowHeight: 0,
                    dividerThickness: 0,
                    columns: [
                      DataColumn(label: Text('Field')),
                      DataColumn(label: Text('Value')),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "Name",
                              style: _fieldTextStyle,
                            ),
                          ),
                          DataCell(
                            Text(
                              playerData['name'] ?? "",
                              style: _valueTextStyle,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "Tournament",
                              style: _fieldTextStyle,
                            ),
                          ),
                          DataCell(
                            Text(
                              playerData['tournament'] ?? "",
                              style: _valueTextStyle,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "Contingent",
                              style: _fieldTextStyle,
                            ),
                          ),
                          DataCell(
                            Text(
                              playerData['tournamentContingent'] ?? "",
                              style: _valueTextStyle,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "Email",
                              style: _fieldTextStyle,
                            ),
                          ),
                          DataCell(
                            Text(
                              playerData['email'] ?? "",
                              style: _valueTextStyle,
                            ),
                          ),
                        ],
                      ),
                      DataRow(
                        cells: [
                          DataCell(
                            Text(
                              "Phone Number",
                              style: _fieldTextStyle,
                            ),
                          ),
                          DataCell(
                            Text(
                              "+91 ${playerData['phoneNumber'] ?? ""}",
                              style: _valueTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => TournamentsPage(),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: Text("Go to Tournaments"),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
