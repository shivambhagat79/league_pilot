import 'package:flutter/material.dart';

class TournamentTable extends StatefulWidget {
  final String tournamentId;
  const TournamentTable({super.key, required this.tournamentId});

  @override
  State<TournamentTable> createState() => _TournamentTableState();
}

class _TournamentTableState extends State<TournamentTable> {
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
                  label: Text("Contingent"),
                ),
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
                DataColumn(
                  label: Text("Points"),
                ),
              ],
              rows: [],
              // rows: [
              //   DataRow(cells: [
              //     DataCell(Text("1")),
              //     DataCell(Text("IIT Ropar")),
              //     DataCell(Text("10")),
              //     DataCell(Text("3")),
              //     DataCell(Text("4")),
              //     DataCell(Text("430")),
              //   ]),
              //   DataRow(cells: [
              //     DataCell(Text("2")),
              //     DataCell(Text("IIT Kanpur")),
              //     DataCell(Text("4")),
              //     DataCell(Text("2")),
              //     DataCell(Text("3")),
              //     DataCell(Text("200")),
              //   ]),
              //   DataRow(cells: [
              //     DataCell(Text("3")),
              //     DataCell(Text("IIT Mandi")),
              //     DataCell(Text("2")),
              //     DataCell(Text("1")),
              //     DataCell(Text("3")),
              //     DataCell(Text("120")),
              //   ]),
              //   DataRow(cells: [
              //     DataCell(Text("4")),
              //     DataCell(Text("Chitkara University")),
              //     DataCell(Text("0")),
              //     DataCell(Text("2")),
              //     DataCell(Text("1")),
              //     DataCell(Text("40")),
              //   ]),
              // ],
            ),
          ),
        ],
      ),
    );
  }
}
