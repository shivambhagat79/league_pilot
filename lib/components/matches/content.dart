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

        return AnimatedScaleContainer(
          child: match is LiveMatchInfo
              ? _buildLiveMatchContainer(match)
              : _buildUpcomingMatchContainer(match),
        );
      },
    );
  }

  Widget _buildLiveMatchContainer(LiveMatchInfo match) {
    return _buildMatchContainer(
      match,
      "Live Now",
      Colors.teal,
      Text(
        "${match.team1Score} vs ${match.team2Score}",
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget _buildUpcomingMatchContainer(UpcomingMatchInfo match) {
    return _buildMatchContainer(
      match,
      "Upcoming",
      Colors.orange,
      const Text(
        "vs",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  Widget _buildMatchContainer(dynamic match, String category, Color color, Widget scoreWidget) {
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
          Text(
            "${match.date} | ${match.time} | ${match.sport}",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeamColumn(match.team1Logo, match.team1Name),
              scoreWidget,
              _buildTeamColumn(match.team2Logo, match.team2Name),
            ],
          ),
          _buildCategoryIndicator(category, color),
        ],
      ),
    );
  }

  Widget _buildTeamColumn(String logoUrl, String teamName) {
    return Column(
      children: [
        Image.network(logoUrl, width: 50, height: 50),
        const SizedBox(height: 5),
        Text(
          teamName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

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

class AnimatedScaleContainer extends StatefulWidget {
  final Widget child;

  const AnimatedScaleContainer({super.key, required this.child});

  @override
  _AnimatedScaleContainerState createState() => _AnimatedScaleContainerState();
}

class _AnimatedScaleContainerState extends State<AnimatedScaleContainer> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: widget.child,
      ),
    );
  }
}

// Models
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
