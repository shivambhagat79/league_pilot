import 'package:flutter/material.dart';

class PointsTable extends StatefulWidget {
  const PointsTable({super.key});

  @override
  State<PointsTable> createState() => _PointsTableState();
}

class _PointsTableState extends State<PointsTable> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Points Table"),
    );
  }
}
