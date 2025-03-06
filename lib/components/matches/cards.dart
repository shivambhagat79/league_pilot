import 'package:flutter/material.dart';
import 'package:hunger_games/utils/sport_to_icon.dart';

class LiveNowCard extends StatefulWidget {
  final Map<String, String> match;
  const LiveNowCard({super.key, required this.match});

  @override
  State<LiveNowCard> createState() => _LiveNowCardState();
}

class _LiveNowCardState extends State<LiveNowCard> {
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
            "${widget.match['date']!}  |  ${widget.match['start_time']!}  |  ${widget.match['venue']!}",
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
                      sportToIcon[widget.match['sport']!],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        widget.match['sport']!,
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
                          widget.match['team_1_score']!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          widget.match['team_1_name']!,
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
                          widget.match['team_2_score']!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          widget.match['team_2_name']!,
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Live Now",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
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
  final Map<String, String> match;
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
            "${match['date']!}  |  ${match['start_time']!}  |  ${match['venue']!}",
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
                      sportToIcon[match['sport']!],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        match['sport']!,
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
                      match['team_1_name']!,
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
                      match['team_2_name']!,
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
  final Map<String, String> match;
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
            "${match['date']!}  |  ${match['start_time']!}  |  ${match['venue']!}",
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
                      sportToIcon[match['sport']!],
                      color: Theme.of(context).colorScheme.onSurface,
                      size: 18,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        match['sport']!,
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
                          match['team_1_score']!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          match['team_1_name']!,
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
                          match['team_2_score']!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        Text(
                          match['team_2_name']!,
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
                    "Verdict: ${match['Verdict']!}",
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
