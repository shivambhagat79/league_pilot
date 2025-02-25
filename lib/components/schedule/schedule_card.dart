import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "11:00",
                style:
                    TextStyle(fontSize: 16, color: Colors.black.withAlpha(180)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 3),
                height: 2,
                width: 8,
                color: Colors.black.withAlpha(150),
              ),
              Text(
                "12:00",
                style:
                    TextStyle(fontSize: 16, color: Colors.black.withAlpha(180)),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "SUN",
                        style: TextStyle(fontSize: 14, letterSpacing: 2),
                      ),
                      Text(
                        "Feb 21",
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        "2025",
                        style: TextStyle(fontSize: 10, letterSpacing: 3),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Basketball Men",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Overcame",
                          color: Colors.black54,
                        ),
                      ),
                      Row(
                        children: [
                          Text("IIT Ropar", style: TextStyle(fontSize: 14)),
                          Text("  v/s  ", style: TextStyle(fontSize: 8)),
                          Text("IIT Kanpur", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      Text("Football Ground", style: TextStyle(fontSize: 10)),
                    ],
                  ),
                  IconButton.outlined(onPressed: () {}, icon: Icon(Icons.map))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
