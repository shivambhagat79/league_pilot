import 'schedule.dart';
import 'scoreboard.dart';

class Match {
  final String
      id; // Unique match identifier (typically the Firestore document ID)
  final String
      tournamentId; // Reference to the tournament this match is part of
  final String sport; // The sport being played (could be an ID or name)
  final Scoreboard scoreboard; // Dynamic scoreboard for the match
  final List<String> teams; // List of participating team IDs
  final Schedule schedule; // The match schedule details
  final String
      status; // For backend use, e.g., "upcoming", "running", "previous"
  final String
      verdict; // Outcome of the match (e.g., winning team ID, tie, etc.)

  Match({
    required this.id,
    required this.tournamentId,
    required this.sport,
    required this.scoreboard,
    required this.teams,
    required this.schedule,
    required this.status,
    required this.verdict,
  });

  // Factory constructor to create a Match instance from a map (e.g., from Firestore)
  factory Match.fromMap(String id, Map<String, dynamic> map) {
    return Match(
      id: id,
      tournamentId: map['tournamentId'] ?? '',
      sport: map['sport'] ?? '',
      scoreboard: map.containsKey('scoreboard')
          ? Scoreboard.fromMap(Map<String, dynamic>.from(map['scoreboard']))
          : Scoreboard(teamScores: {}),
      teams: List<String>.from(map['teams'] ?? []),
      schedule: Schedule.fromMap(Map<String, dynamic>.from(map['schedule'])),
      status: map['status'] ?? '',
      verdict: map['verdict'] ?? '',
    );
  }

  // Converts a Match instance into a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'tournamentId': tournamentId,
      'sport': sport,
      'scoreboard': scoreboard.toMap(),
      'teams': teams,
      'schedule': schedule.toMap(),
      'status': status,
      'verdict': verdict,
    };
  }
}
