import 'package:flutter/material.dart';
import 'package:hunger_games/components/matches/matchesAppBar.dart';
import 'package:hunger_games/components/matches/tab.dart';
import 'package:hunger_games/components/matches/content.dart';

class Matches extends StatefulWidget {
  const Matches({super.key});

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  final ScrollController scrollController = ScrollController();

  String selectedTab = "Live Now"; // Default category
  String selectedSport = "All"; // Default sport selection (new "All" tab)

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 5,
      radius: const Radius.circular(10),
      controller: scrollController,
      child: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          MatchesAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Heading(text: "EXPLORE"),

                // Tab Buttons (Live Now & Upcoming)
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

                // Display Content Based on Selection
                _buildContent(),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("© League Pilot. All rights reserved."),
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  // Dummy Data for Matches (Live & Upcoming)
  List<dynamic> getMatches() {
    List<dynamic> matches = [
      // Live Matches (Include Scores)
      LiveMatchInfo(
        team1Name: "IIT Ropar",
        team2Name: "IIT Kanpur",
        team1Logo: "assets/images/components/iit-ropar.jpg",
        team2Logo: "assets/images/components/iit-kanpur.jpg",
        team1Score: 120, // Cricket score
        team2Score: 115,
        date: "Feb 25, 2025",
        time: "10:00 AM",
        sport: "Cricket",
      ),
      LiveMatchInfo(
        team1Name: "IIT Ropar",
        team2Name: "IIT Kanpur",
        team1Logo: "assets/images/components/iit-ropar.jpg",
        team2Logo: "assets/images/components/iit-kanpur.jpg",
        team1Score: 2, // Football score
        team2Score: 1,
        date: "Feb 27, 2025",
        time: "6:30 PM",
        sport: "Football",
      ),

      // Upcoming Matches (No Scores)
      UpcomingMatchInfo(
        team1Name: "IIT Ropar",
        team2Name: "IIT Kanpur",
        team1Logo: "assets/images/components/iit-ropar.jpg",
        team2Logo: "assets/images/components/iit-kanpur.jpg",
        date: "Feb 26, 2025",
        time: "4:00 PM",
        sport: "Volleyball",
      ),
    ];

    // Filter matches based on selectedTab (Live Now / Upcoming) and selectedSport
    return matches.where((match) {
      bool categoryMatch = (selectedTab == "Live Now" && match is LiveMatchInfo) ||
          (selectedTab == "Upcoming" && match is UpcomingMatchInfo);
      bool sportMatch = selectedSport == "All" || match.sport == selectedSport;
      return categoryMatch && sportMatch;
    }).toList();
  }

  // Content Section (Displays matches based on category & sport selection)
  Widget _buildContent() {
    List<dynamic> filteredMatches = getMatches();

    return Container(
      width: double.infinity,
      height: 350, // Adjust height dynamically
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: filteredMatches.isEmpty
          ? const Center(
              child: Text(
                "No matches available",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
              ),
            )
          : MatchContent(matches: filteredMatches),
    );
  }
}
