import 'package:flutter/material.dart';
import 'package:hunger_games/utils/sport_to_icon.dart';

class SportsTable extends StatefulWidget {
  final String sport;
  final List<Map<String, dynamic>> standings;
  const SportsTable({super.key, required this.sport, required this.standings});

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
              Icon(sportToIcon[
                  widget.sport[0].toUpperCase() + widget.sport.substring(1)]),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  widget.sport.replaceAll('_', ' '),
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
              rows: widget.standings
                  .map(
                    (team) => DataRow(
                      cells: [
                        DataCell(Text(
                            (widget.standings.indexOf(team) + 1).toString())),
                        DataCell(Text(team['contingentId'])),
                        DataCell(Text(team['points'].toString())),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
