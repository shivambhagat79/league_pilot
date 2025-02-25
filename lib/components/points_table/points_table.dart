import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';

class PointsTable extends StatefulWidget {
  const PointsTable({super.key});

  @override
  State<PointsTable> createState() => _PointsTableState();
}

class _PointsTableState extends State<PointsTable> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Points Table",
      child: Container(
        height: 1000,
        // color: Colors.teal,
      ),
    );
  }
}
