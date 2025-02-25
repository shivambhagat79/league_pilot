import 'package:flutter/material.dart';
import 'package:hunger_games/components/points_table/sports_table.dart';

class SportsTablesContainer extends StatefulWidget {
  const SportsTablesContainer({super.key});

  @override
  State<SportsTablesContainer> createState() => _SportsTablesContainerState();
}

class _SportsTablesContainerState extends State<SportsTablesContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.teal.shade900.withAlpha(190),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: Alignment.center,
                  child: Text(
                    "Sports Tables",
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 22,
                      fontFamily: 'Overcame',
                      color: Colors.black.withAlpha(190),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 50,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade900.withAlpha(190),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Column(
            children: List.generate(5, (index) {
              return SportsTable();
            }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text("© League Pilot. All rights reserved.",
                style: TextStyle(color: Colors.white.withAlpha(190))),
          ),
          SizedBox(height: 500),
        ],
      ),
    );
  }
}
