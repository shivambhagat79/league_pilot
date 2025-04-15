import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/services/match_service.dart';
import 'package:hunger_games/services/points_service.dart';

class SportPage extends StatefulWidget {
  final String sport;
  final String tournamentId;
  const SportPage({super.key, required this.sport, required this.tournamentId});

  @override
  State<SportPage> createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  final PointsService _pointsService = PointsService();
  final MatchService _matchService = MatchService();
  late List<Map<String, dynamic>> _pointsTable;
  bool _isLoading = false;

  Future<void> _fetchSportTable() async {
    setState(() {
      _isLoading = true;
    });

    final List<Map<String, dynamic>> pointsTable =
        await _pointsService.getSportTable(widget.tournamentId, widget.sport);

    setState(() {
      _pointsTable = pointsTable;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchSportTable();
  }

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: widget.sport,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: _isLoading
            ? LinearProgressIndicator()
            : Column(
                children: [
                  Text(
                    "Scoreboard",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Overcame",
                        letterSpacing: 5,
                        color: Colors.black54),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: double.maxFinite,
                    child: DataTable(
                      dataTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      headingTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      columnSpacing: 10,
                      columns: [
                        DataColumn(
                          label: Text("Rank"),
                        ),
                        DataColumn(
                          label: Text("Team"),
                        ),
                        DataColumn(
                          label: Text("W"),
                        ),
                        DataColumn(
                          label: Text("L"),
                        ),
                        DataColumn(
                          label: Text("D"),
                        ),
                        DataColumn(
                          label: Text("Points"),
                        ),
                        if (widget.sport == "Cricket")
                          DataColumn(label: Text("NRR")),
                      ],
                      rows: _pointsTable
                          .map(
                            (team) => DataRow(
                              cells: [
                                DataCell(Text((_pointsTable.indexOf(team) + 1)
                                    .toString())),
                                DataCell(Text(team['contingentId'])),
                                DataCell(Text(team['wins'].toString())),
                                DataCell(Text(team['losses'].toString())),
                                DataCell(Text(team['draws'].toString())),
                                DataCell(Text(team['points'].toString())),
                                if (widget.sport == "Cricket")
                                  DataCell(
                                    Text(
                                      (team['netRunRate'] ?? 0.0).toString(),
                                      style: TextStyle(
                                        color: (team['netRunRate'] ?? 0.0) > 0.0
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Divider(height: 40, thickness: 1),
                  SizedBox(height: 10),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("End Sport?"),
                                content: Text(
                                    "Are you sure you want to end this sport?\nMedals will be awarded and locked after this action."),
                                actions: [
                                  FilledButton(
                                    onPressed: () async {
                                      bool success =
                                          await _matchService.endSport(
                                        tournamentId: widget.tournamentId,
                                        sportName: widget.sport,
                                      );

                                      if (success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Sport ended successfully"),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text("Failed to end sport"),
                                          ),
                                        );
                                      }

                                      Navigator.of(context).pop();
                                    },
                                    child: Text("End"),
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
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      child: Text("End Sport"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
