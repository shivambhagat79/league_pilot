import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/services/teamservice.dart';

class Players extends StatefulWidget {
  final String tournamentId;
  final String contingent;
  final String sport;
  const Players({
    super.key,
    required this.tournamentId,
    required this.contingent,
    required this.sport,
  });

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  final TeamService _teamService = TeamService();
  Map<String, dynamic>? _teamData;

  bool _isLoading = false;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic>? teamData = await _teamService.getTeam(
      tournamentId: widget.tournamentId,
      contingent: widget.contingent,
      sport: widget.sport,
    );

    if (teamData != null) {
      setState(() {
        _teamData = teamData;
        _isLoading = false;
      });
      return;
    } else {
      // Handle the case where team data is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Team data not found"),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
        title: "${widget.sport} Team",
        child: _isLoading
            ? LinearProgressIndicator()
            : Column(
                children: [
                  Text(
                    "Players",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Overcame",
                        letterSpacing: 5,
                        color: Colors.black54),
                  ),
                  _teamData != null
                      ? Container(
                          decoration: BoxDecoration(
                              // border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.teal.shade500.withAlpha(50)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 20),
                                child: Icon(
                                  Icons.military_tech,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Team Captain",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(_teamData!['captainName'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                  Text(
                                    _teamData!['captainEmail'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Text(
                            "No Team Data Found",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                  _teamData == null
                      ? Container()
                      : Column(
                          children: _teamData?['players'].map<Widget>((player) {
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  title: Text(player['name']),
                                  subtitle: Text(player['email']),
                                  leading: Icon(Icons.person),
                                ),
                                const Divider(height: 0),
                              ],
                            );
                          }).toList(),
                        ),
                ],
              ));
  }
}
