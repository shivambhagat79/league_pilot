import 'package:flutter/material.dart';
import 'package:hunger_games/components/common/custom_scroll_page.dart';
import 'package:hunger_games/components/matches/cards.dart';
import 'package:hunger_games/components/matches/sample_data.dart';
import 'package:hunger_games/components/matches/tab.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  String selectedTab = "Live Now"; // Default category
  String selectedSport = "All"; // Default sport selection (new "All" tab)

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> matches = matchData.where((match) {
      bool statusMatch = (match['status'] == selectedTab);
      bool sportMatch =
          (selectedSport == 'All' || match['sport'] == selectedSport);

      return statusMatch && sportMatch;
    }).toList();

    return Customscrollpage(
      title: "Matches",
      child: Column(
        children: [
          TabButtons(
            selectedTab: selectedTab,
            selectedSport: selectedSport,
            onTabChange: (String newTab) {
              setState(() {
                selectedTab = newTab;
                selectedSport = "All"; // Reset sport when category changes
              });
            },
            onSportChange: (String newSport) {
              setState(() {
                selectedSport = newSport;
              });
            },
          ),

          (matches.isEmpty)
              ? Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: Text(
                    "No Matches to Display.",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : Column(
                  children: matches.map((match) {
                    if (match['status'] == 'Live Now') {
                      return LiveNowCard(match: match);
                    } else if (match['status'] == 'Upcoming') {
                      return UpcomingCard(match: match);
                    } else {
                      return ResultsCard(match: match);
                    }
                  }).toList(),
                ),

          // Footer
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text("© League Pilot. All rights reserved."),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
