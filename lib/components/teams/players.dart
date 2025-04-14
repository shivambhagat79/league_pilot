import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';

class Players extends StatefulWidget {
  final String tournamentId;
  final String contingent;
  final String sport;
  const Players({
    super.key,
    required this.tournamentId,
    required this.contingent,
    required this.sport,
  });

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  @override
  Widget build(BuildContext context) {
    return Customscrollpage(
        title: "${widget.sport} Team",
        child: Column(
          children: [
            Text(
              "Players",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Overcame",
                  letterSpacing: 5,
                  color: Colors.black54),
            ),
            Container(
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.teal.shade500.withAlpha(50)),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Icon(
                      Icons.military_tech,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Team Captain",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Text("Player 1",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      Text(
                        "Playe1@iitrpr.ac.in",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(10, (index) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      title: Text("Player ${index + 1}"),
                      subtitle: Text("Player${index + 1}@iitrpr.ac.in"),
                      leading: Icon(Icons.person),
                    ),
                    const Divider(height: 0),
                  ],
                );
              }),
            ),
          ],
        ));
  }
}
