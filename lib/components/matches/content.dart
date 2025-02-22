import 'package:flutter/material.dart';

class MatchContent extends StatelessWidget {
  final List<dynamic> matches; // Accepts both LiveMatchInfo & UpcomingMatchInfo

  const MatchContent({super.key, required this.matches});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];

        if (match is LiveMatchInfo) {
          return _buildLiveMatchContainer(match);
        } else if (match is UpcomingMatchInfo) {
          return _buildUpcomingMatchContainer(match);
        } else {
          return const SizedBox(); // Handles unexpected cases
        }
      },
    );
  }

  // Live Match Container (Displays scores)
  Widget _buildLiveMatchContainer(LiveMatchInfo match) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          // Date, Time & Sport at the top center
          Text(
            "${match.date} | ${match.time} | ${match.sport}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          const SizedBox(height: 8),

          // Match Row (Logos, Names, Scores, and VS)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamColumn(match.team1Logo, match.team1Name),

              // Score and "VS" in the middle
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        match.team1Score.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "vs",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        match.team2Score.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                    ],
                  ),
                ],
              ),

              _buildTeamColumn(match.team2Logo, match.team2Name),
            ],
          ),

          // Category Indicator (Live Now)
          _buildCategoryIndicator("Live Now", Colors.teal),
        ],
      ),
    );
  }

  // Upcoming Match Container (No Scores)
  Widget _buildUpcomingMatchContainer(UpcomingMatchInfo match) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Column(
        children: [
          // Date, Time & Sport at the top center
          Text(
            "${match.date} | ${match.time} | ${match.sport}",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.orange),
          ),
          const SizedBox(height: 8),

          // Match Row (Logos, Names, No Scores)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamColumn(match.team1Logo, match.team1Name),
              const Text(
                "vs",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              _buildTeamColumn(match.team2Logo, match.team2Name),
            ],
          ),

          // Category Indicator (Upcoming)
          _buildCategoryIndicator("Upcoming", Colors.orange),
        ],
      ),
    );
  }

  // Common method for team logos and names
  Widget _buildTeamColumn(String logoUrl, String teamName) {
    return Column(
      children: [
        Image.network(logoUrl, width: 50, height: 50), // Team Logo
        const SizedBox(height: 5),
        Text(
          teamName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  // Category Indicator (Live Now / Upcoming)
  Widget _buildCategoryIndicator(String category, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        category,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

// Live Match Model (Includes Scores)
class LiveMatchInfo {
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final int team1Score;
  final int team2Score;
  final String date;
  final String time;
  final String sport;

  LiveMatchInfo({
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.team1Score,
    required this.team2Score,
    required this.date,
    required this.time,
    required this.sport,
  });
}

// Upcoming Match Model (No Scores)
class UpcomingMatchInfo {
  final String team1Name;
  final String team2Name;
  final String team1Logo;
  final String team2Logo;
  final String date;
  final String time;
  final String sport;

  UpcomingMatchInfo({
    required this.team1Name,
    required this.team2Name,
    required this.team1Logo,
    required this.team2Logo,
    required this.date,
    required this.time,
    required this.sport,
  });
}
