import 'package:flutter/material.dart';

class SportsTable extends StatefulWidget {
  const SportsTable({super.key});

  @override
  State<SportsTable> createState() => _SportsTableState();
}

class _SportsTableState extends State<SportsTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.sports_soccer),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  "Football",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 20,
                    fontFamily: 'Overcame',
                    color: Colors.black.withAlpha(190),
                  ),
                ),
              ),
            ],
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
                  label: Text("Team"),
                ),
                DataColumn(
                  label: Text("Points"),
                ),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(Text("1")),
                    DataCell(Text("IIT Ropar")),
                    DataCell(Text("100")),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("2")),
                    DataCell(Text("IIT Kanpur")),
                    DataCell(Text("90")),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("3")),
                    DataCell(Text("IIT Mandi")),
                    DataCell(Text("80")),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text("4")),
                    DataCell(Text("Chitkara University")),
                    DataCell(Text("70")),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
