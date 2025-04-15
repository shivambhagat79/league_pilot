import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hunger_games/components/common/heading_cut_card.dart';
import 'package:hunger_games/services/dashboard_utility.dart';

class DashboardActivities extends StatefulWidget {
  final String tournamentId;
  const DashboardActivities({super.key, required this.tournamentId});

  @override
  State<DashboardActivities> createState() => _DashboardActivitiesState();
}

class _DashboardActivitiesState extends State<DashboardActivities> {
  final DashboardService _dashboardService = DashboardService();
  late List<Map<String, dynamic>> _recentMatches;
  bool _isLoading = true;
  bool _isVisible = true;

  Future<void> _fetchRecentMatches() async {
    setState(() {
      _isLoading = true;
    });

    List<Map<String, dynamic>> recentMatches =
        await _dashboardService.getRecentMatches(widget.tournamentId);

    setState(() {
      _recentMatches = recentMatches;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRecentMatches();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : HeadingCutCard(
            heading: "DASHBOARD",
            tail: Container(
              margin: EdgeInsets.only(top: 6),
              alignment: Alignment.center,
              width: double.maxFinite,
              child: Text(
                "RECENT ACTIVITY",
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontFamily: "Overcame",
                  fontSize: 18,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ),
            child: SizedBox(
                height: 200,
                child: FlutterCarousel(
                  options: FlutterCarouselOptions(
                    height: 400.0,
                    showIndicator: true,
                    slideIndicator: CircularSlideIndicator(),
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    enlargeCenterPage: true,
                    floatingIndicator: false,
                  ),
                  items: _recentMatches.isEmpty
                      ? [
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "No Recent Matches",
                              style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontFamily: "Overcame",
                                fontSize: 18,
                                color: Colors.white54,
                              ),
                            ),
                          )
                        ]
                      : _recentMatches.map((match) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${match['sport']} ${match['gender']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontFamily: "Overcame",
                                        fontSize: 18,
                                        color: Colors.black.withAlpha(190),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          match['teams'][0],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color:
                                                  Colors.black.withAlpha(190)),
                                        ),
                                        Text("v/s"),
                                        Text(
                                          match['teams'][1],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color:
                                                  Colors.black.withAlpha(190)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          (match["sport"] == "Cricket")
                                              ? "${match["scoreboard"][match['teams'][0]]['runs'].toString()} / ${match["scoreboard"][match['teams'][0]]['wickets'].toString()}"
                                              : match['scoreboard']
                                                          ['teamScores']
                                                      [match['teams'][0]]
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color:
                                                  Colors.black.withAlpha(190)),
                                        ),
                                        Text("-"),
                                        Text(
                                          (match["sport"] == "Cricket")
                                              ? "${match["scoreboard"][match['teams'][1]]['runs'].toString()} / ${match["scoreboard"][match['teams'][1]]['wickets'].toString()}"
                                              : match['scoreboard']
                                                          ['teamScores']
                                                      [match['teams'][1]]
                                                  .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color:
                                                  Colors.black.withAlpha(190)),
                                        ),
                                      ],
                                    ),
                                    match['status'] == 'live'
                                        ? AnimatedOpacity(
                                            opacity: _isVisible ? 1.0 : 0.0,
                                            duration: Duration(seconds: 1),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.red.shade800,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                "Live Now",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                              ),
                                            ),
                                          )
                                        : match['status'] == 'upcoming'
                                            ? Text(
                                                "Scheduled: ${match['schedule']['date'].toDate().toString().split(" ")[0]}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withAlpha(190),
                                                ),
                                              )
                                            : Text(
                                                "Verdict: ${match['verdict']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withAlpha(190),
                                                ),
                                              ),
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                )),
          );
  }
}
