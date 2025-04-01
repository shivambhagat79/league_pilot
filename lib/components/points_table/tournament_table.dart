import 'package:flutter/material.dart';
import 'package:hunger_games/services/points_service.dart';

class TournamentTable extends StatefulWidget {
  final String tournamentId;
  const TournamentTable({super.key, required this.tournamentId});

  @override
  State<TournamentTable> createState() => _TournamentTableState();
}

class _TournamentTableState extends State<TournamentTable> {
  final PointsService _pointsService = PointsService();
  late Stream<List<Map<String, dynamic>>> _pointsTable;

  bool _isLoading = false;

  Future<void> _fetchPointsTable() async {
    setState(() {
      _isLoading = true;
    });

    Stream<List<Map<String, dynamic>>> pointsTable =
        _pointsService.streamGeneralTable(widget.tournamentId);

    setState(() {
      _pointsTable = pointsTable;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPointsTable();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.teal.shade900.withAlpha(190),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "Tournament Table",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 22,
              fontFamily: 'Overcame',
              color: Colors.white.withAlpha(230),
            ),
          ),
          Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder(
                      stream: _pointsTable,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Error: ${snapshot.error}",
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "No data available",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          final List<Map<String, dynamic>> pointsTable =
                              snapshot.data!;
                          return DataTable(
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
                              DataColumn(label: Text("Rank")),
                              DataColumn(label: Text("Contingent")),
                              DataColumn(
                                label: Icon(
                                  Icons.emoji_events,
                                  color: Colors.amber.shade600,
                                  size: 18,
                                ),
                              ),
                              DataColumn(
                                label: Icon(
                                  Icons.emoji_events,
                                  color: Colors.blueGrey,
                                  size: 18,
                                ),
                              ),
                              DataColumn(
                                label: Icon(
                                  Icons.emoji_events,
                                  color: Colors.deepOrange.shade900,
                                  size: 18,
                                ),
                              ),
                              DataColumn(label: Text("Points")),
                            ],
                            rows: pointsTable
                                .map((row) => DataRow(cells: [
                                      DataCell(Text(
                                          (pointsTable.indexOf(row) + 1)
                                              .toString())),
                                      DataCell(Text(row['contingentId'])),
                                      DataCell(Text(row['gold'].toString())),
                                      DataCell(Text(row['silver'].toString())),
                                      DataCell(Text(row['bronze'].toString())),
                                      DataCell(Text(row['points'].toString())),
                                    ]))
                                .toList(),
                          );
                        }
                      })),
          // : DataTable(
          //     dataTextStyle: TextStyle(
          //       color: Colors.black,
          //       fontSize: 12,
          //     ),
          //     headingTextStyle: TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //     ),
          //     columnSpacing: 10,
          //     columns: [
          //       DataColumn(
          //         label: Text("Rank"),
          //       ),
          //       DataColumn(
          //         label: Text("Contingent"),
          //       ),
          //       DataColumn(
          //         label: Icon(
          //           Icons.emoji_events,
          //           color: Colors.amber.shade600,
          //           size: 18,
          //         ),
          //       ),
          //       DataColumn(
          //         label: Icon(
          //           Icons.emoji_events,
          //           color: Colors.blueGrey,
          //           size: 18,
          //         ),
          //       ),
          //       DataColumn(
          //         label: Icon(
          //           Icons.emoji_events,
          //           color: Colors.deepOrange.shade900,
          //           size: 18,
          //         ),
          //       ),
          //       DataColumn(
          //         label: Text("Points"),
          //       ),
          //     ],
          //     rows: [],
          //     // rows: [
          //     //   DataRow(cells: [
          //     //     DataCell(Text("1")),
          //     //     DataCell(Text("IIT Ropar")),
          //     //     DataCell(Text("10")),
          //     //     DataCell(Text("3")),
          //     //     DataCell(Text("4")),
          //     //     DataCell(Text("430")),
          //     //   ]),
          //     //   DataRow(cells: [
          //     //     DataCell(Text("2")),
          //     //     DataCell(Text("IIT Kanpur")),
          //     //     DataCell(Text("4")),
          //     //     DataCell(Text("2")),
          //     //     DataCell(Text("3")),
          //     //     DataCell(Text("200")),
          //     //   ]),
          //     //   DataRow(cells: [
          //     //     DataCell(Text("3")),
          //     //     DataCell(Text("IIT Mandi")),
          //     //     DataCell(Text("2")),
          //     //     DataCell(Text("1")),
          //     //     DataCell(Text("3")),
          //     //     DataCell(Text("120")),
          //     //   ]),
          //     //   DataRow(cells: [
          //     //     DataCell(Text("4")),
          //     //     DataCell(Text("Chitkara University")),
          //     //     DataCell(Text("0")),
          //     //     DataCell(Text("2")),
          //     //     DataCell(Text("1")),
          //     //     DataCell(Text("40")),
          //     //   ]),
          //     // ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
