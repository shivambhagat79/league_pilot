import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/schedule/schedule_card.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
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
      title: "Schedule",
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "Filter by sports",
              style: TextStyle(
                  fontSize: 20, fontFamily: "Overcame", color: Colors.black54),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: sports
                  .map((sport) => Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: FilterChip(
                          label: Text(sport),
                          selected: selected.contains(sport),
                          onSelected: (bool selected) {
                            if (selected) {
                              setState(() {
                                this.selected.add(sport);
                              });
                            } else {
                              setState(() {
                                this.selected.remove(sport);
                              });
                            }
                          },
                        ),
                      ))
                  .toList(),
            ),
          ),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.teal.shade900.withAlpha(50),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: List.generate(6, (index) {
                    return ScheduleCard();
                  }),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("© League Pilot. All rights reserved."),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
