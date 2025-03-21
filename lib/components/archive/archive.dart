import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';

class Archive extends StatefulWidget {
  const Archive({super.key});

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  List<String> sports = [
    "Football",
    "Basketball",
    "Cricket",
    "Volleyball",
    "Hockey",
    "Badminton",
    "Lawn Tennis",
    "Chess"
  ];

  List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
      title: "Archive",
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text("© League Pilot. All rights reserved."),
          ),
          SizedBox(height: 80),
        ]
         // Adds spacing at the bottom

      ),
    );
  }
}
