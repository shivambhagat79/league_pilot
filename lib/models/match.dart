import 'schedule.dart';
import 'scoreboard.dart';
import 'cricket_scoreboard.dart';
class Match {
  // Unique match identifier (typically the Firestore document ID)
  final String
      tournamentId;// name of  tournament this match is part of
  final String sport; // The sport being played (could be an ID or name)
  final String gender;
  final int winpoints;
  final int losepoints;
  final int drawpoints;
  final dynamic scoreboard; //Dynamic scoreboard for the match
  final List<String> teams; // List of participating team names
  final Schedule schedule; // The match schedule details
  final String
      status; // For backend use, e.g., "upcoming", "running", "previous"
  final String
      verdict; // Outcome of the match (e.g., winning team ID, tie, etc.)
  final int statusPriority ; 
  final String scorekeeperEmail; // Email of the user who is the scorekeeper for this match   

  Match({
    required this.tournamentId,
    required this.sport,
    required this.gender,
    required this.winpoints,
    required this.losepoints,
    required this.drawpoints,
    required this.scoreboard,
    required this.teams,
    required this.schedule,
    required this.status,
    required this.verdict,
    required this.statusPriority,
    required this.scorekeeperEmail,
  });

  // Factory constructor to create a Match instance from a map (e.g., from Firestore)
  factory Match.fromMap(String id, Map<String, dynamic> map) {
    return Match(
      tournamentId: map['tournamentId'] ?? '',
      sport: map['sport'] ?? '',
      gender: map['gender'] ?? '',
      winpoints: map['winpoints'] ?? 0,
      losepoints: map['losepoints'] ?? 0,
      drawpoints: map['drawpoints'] ?? 0,
      scoreboard: map.containsKey('scoreboard')
          ? (map['sport']?.toLowerCase() == 'cricket'
              ? CricketScoreboard.fromMap(Map<String, dynamic>.from(map['scoreboard']))
              : Scoreboard.fromMap(Map<String, dynamic>.from(map['scoreboard'])))
          : (map['sport']?.toLowerCase() == 'cricket'
              ? CricketScoreboard(teamStats: {})
              : Scoreboard(teamScores: {})),
          
      teams: List<String>.from(map['teams'] ?? []),
      schedule: Schedule.fromMap(Map<String, dynamic>.from(map['schedule'])),
      status: map['status'] ?? '',
      verdict: map['verdict'] ?? '',
      statusPriority: map['statusPriority'] ?? 0,
      scorekeeperEmail: map['scorekeeperEmail'] ?? '',
    );
  }

  // Converts a Match instance into a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'tournamentId': tournamentId,
      'sport': sport,
      'gender': gender,
      'winpoints': winpoints,
      'losepoints': losepoints,
      'drawpoints': drawpoints,
      'scoreboard': scoreboard is CricketScoreboard
          ? (scoreboard as CricketScoreboard).toMap()
          : (scoreboard as Scoreboard).toMap(),
      'teams': teams,
      'schedule': schedule.toMap(),
      'status': status,
      'verdict': verdict,
      'statusPriority': statusPriority,
      'scorekeeperEmail': scorekeeperEmail,
    };
  }
}
