import 'package:flutter/material.dart';
import 'package:hunger_games/components/teams/teamsAppBar.dart';
import 'package:hunger_games/components/teams/teamCard.dart';

class Teams extends StatefulWidget {
  const Teams({super.key});

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Use TeamsAppBar inside the slivers
          const TeamsAppBar(),
          
          // Wrap non-sliver widgets inside SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Column(
              children: [
                TeamCard(
                  teamName: "IIT Ropar",
                  logoUrl: "assets/images/components/iit-ropar.jpg",
                  description: "A competitive and passionate team from IIT Ropar.",
                ),
                const SizedBox(height: 10),
                TeamCard(
                  teamName: "IIT Kanpur",
                  logoUrl: "assets/images/components/iit-kanpur.jpg",
                  description: "A well-experienced and skilled team from IIT Kanpur.",
                ),
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text(
                      "© League Pilot. All rights reserved.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
