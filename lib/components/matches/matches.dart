import 'package:flutter/material.dart';
import 'package:hunger_games/components/matches/matchesAppBar.dart';
import 'package:hunger_games/components/matches/tab.dart';
import 'package:hunger_games/components/matches/heading.dart';

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
                Heading(text: "EXPLORE"),

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
              ],
            ),
          )
        ],
      ),
    );
  }

  // Content Section (Displays matches based on category & sport selection)
  Widget _buildContent() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Center(
        child: Text(
          "Displaying $selectedTab matches for $selectedSport",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
      ),
    );
  }
}
