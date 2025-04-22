import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/services/player_service.dart';
import 'package:hunger_games/services/tournament_service.dart';

class ScannedPlayerPage extends StatefulWidget {
  final String scannedString;
  const ScannedPlayerPage({super.key, required this.scannedString});

  @override
  State<ScannedPlayerPage> createState() => _ScannedPlayerPageState();
}

class _ScannedPlayerPageState extends State<ScannedPlayerPage> {
  final PlayerService _playerService = PlayerService();
  final TournamentService _tournamentService = TournamentService();
  final TextStyle _fieldTextStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final TextStyle _valueTextStyle = TextStyle(fontSize: 16);

  bool _isLoading = false;
  bool _playerExists = false;
  Map<String, dynamic> _playerData = {};

  Future<void> _getPlayer() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> playerData =
        await _playerService.getPlayer(widget.scannedString);

    if (playerData.isNotEmpty) {
      String tournamentName =
          await _tournamentService.getTournamentName(playerData['tournament']);

      setState(() {
        playerData['tournament'] = tournamentName;
        _playerData = playerData;
        _playerExists = true;
      });
    } else {
      setState(() {
        _playerExists = false;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: 'Player Data',
      child: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : !_playerExists
              ? SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error,
                        size: 80,
                        color: Colors.red.shade600,
                      ),
                      const SizedBox(height: 20),
                      const Center(
                        child: Text(
                          "Invalid QR Code",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Overcame",
                            letterSpacing: 3,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "Player Info",
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Overcame",
                            letterSpacing: 5,
                            color: Colors.black54),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.teal.shade900,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.teal.shade900,
                        ),
                      ),
                      SizedBox(height: 30),
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
                                    _playerData['name'] ?? "",
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
                                    _playerData['tournament'] ?? "",
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
                                    _playerData['tournamentContingent'] ?? "",
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
                                    _playerData['email'] ?? "",
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
                                    "+91 ${_playerData['phoneNumber'] ?? ""}",
                                    style: _valueTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "Verified",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Overcame",
                                letterSpacing: 5,
                                color: Colors.teal.shade900.withAlpha(160),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.check_circle,
                            color: Colors.teal.shade900,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Text("© League Pilot. All rights reserved."),
                      ),
                      SizedBox(height: 80),
                    ],
                  ),
                ),
    );
  }
}
