import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/points_table/sports_tables_container.dart';
import 'package:hunger_games/components/points_table/tournament_table.dart';

class PointsTable extends StatefulWidget {
  final String tournamentId;
  const PointsTable({super.key, required this.tournamentId});

  @override
  State<PointsTable> createState() => _PointsTableState();
}

class _PointsTableState extends State<PointsTable> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Points Table",
      child: Column(
        children: [
          TournamentTable(tournamentId: widget.tournamentId),
          SportsTablesContainer(),
        ],
      ),
    );
  }
}
