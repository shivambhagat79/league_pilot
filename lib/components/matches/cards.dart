import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hunger_games/utils/sport_to_icon.dart';

class LiveNowCard extends StatefulWidget {
  final Map<String, dynamic> match;
  const LiveNowCard({super.key, required this.match});

  @override
  State<LiveNowCard> createState() => _LiveNowCardState();
}

class _LiveNowCardState extends State<LiveNowCard> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "${widget.match['schedule']['date'].toDate().toString().split(' ')[0]}  |  ${widget.match['schedule']['starttime']['hour']}:${widget.match['schedule']['starttime']['minute']}  |  ${widget.match['schedule']['venue']}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      sportToIcon[widget.match['sport']],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        widget.match['sport'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: "Overcame",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          (widget.match["sport"] == "Cricket")
                              ? "${widget.match["scoreboard"][widget.match['teams'][0]]['runs'].toString()} / ${widget.match["scoreboard"][widget.match['teams'][0]]['wickets'].toString()}"
                              : widget.match['scoreboard']['teamScores']
                                      [widget.match['teams'][0]]
                                  .toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (widget.match["sport"] == "Cricket")
                          Text(
                            "${widget.match["scoreboard"][widget.match['teams'][0]]['overs'].toString()} overs",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        Text(
                          widget.match['teams'][0],
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "V/S",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          (widget.match["sport"] == "Cricket")
                              ? "${widget.match["scoreboard"][widget.match['teams'][1]]['runs'].toString()} / ${widget.match["scoreboard"][widget.match['teams'][1]]['wickets'].toString()}"
                              : widget.match['scoreboard']['teamScores']
                                      [widget.match['teams'][1]]
                                  .toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (widget.match["sport"] == "Cricket")
                          Text(
                            "${widget.match["scoreboard"][widget.match['teams'][1]]['overs'].toString()} overs",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        Text(
                          widget.match['teams'][1],
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AnimatedOpacity(
                  opacity: _isVisible ? 1.0 : 0.0,
                  duration: Duration(seconds: 1),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Live Now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpcomingCard extends StatelessWidget {
  final Map<String, dynamic> match;
  const UpcomingCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "${match['schedule']['date'].toDate().toString().split(' ')[0]}  |  ${match['schedule']['starttime']['hour']}:${match['schedule']['starttime']['minute']}  |  ${match['schedule']['venue']}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      sportToIcon[match['sport']],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        match['sport'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: "Overcame",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      match['teams'][0],
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      "V/S",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      match['teams'][1],
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
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

class ResultsCard extends StatelessWidget {
  final Map<String, dynamic> match;
  const ResultsCard({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "${match['schedule']['date'].toDate().toString().split(' ')[0]}  |  ${match['schedule']['starttime']['hour']}:${match['schedule']['starttime']['minute']}  |  ${match['schedule']['venue']}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(14),
            ),
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      sportToIcon[match['sport']],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        match['sport'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                          fontFamily: "Overcame",
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          (match["sport"] == "Cricket")
                              ? "${match["scoreboard"][match['teams'][0]]['runs'].toString()} / ${match["scoreboard"][match['teams'][0]]['wickets'].toString()}"
                              : match['scoreboard']['teamScores']
                                      [match['teams'][0]]
                                  .toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (match["sport"] == "Cricket")
                          Text(
                            "${match["scoreboard"][match['teams'][0]]['overs'].toString()} overs",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        Text(
                          match['teams'][0],
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "V/S",
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          (match["sport"] == "Cricket")
                              ? "${match["scoreboard"][match['teams'][1]]['runs'].toString()} / ${match["scoreboard"][match['teams'][1]]['wickets'].toString()}"
                              : match['scoreboard']['teamScores']
                                      [match['teams'][1]]
                                  .toString(),
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        if (match["sport"] == "Cricket")
                          Text(
                            "${match["scoreboard"][match['teams'][1]]['overs'].toString()} overs",
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        Text(
                          match['teams'][1],
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(vertical: 2),
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Verdict: ${match['verdict']}",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
