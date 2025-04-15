import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // for TimeOfDay
import '../models/match.dart';
import '../models/schedule.dart';
import '../models/scoreboard.dart';
import 'points_service.dart';
import '../models/cricket_scoreboard.dart';

class MatchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Creates a new match document in Firestore using the updated Schedule model.
  ///
  /// Parameters:
  /// - [sport]: The sport being played.
  /// - [tournamentId]: The ID or name of the tournament this match belongs to.
  /// - [gender]: "Men", "Women", "Mixed", etc.
  /// - [venue]: The venue where the match is held.
  /// - [team1], [team2]: Names/IDs of the two participating teams.
  /// - [date]: The date of the match.
  /// - [startTime], [endTime]: TimeOfDay objects for the match start/end times.
  ///
  /// Returns the newly created document ID, or `null` on error.
  Future<String?> createMatch({
    required String sport,
    required String tournamentId,
    required String gender,
    required String winPoints1,
    required String losePoints1,
    required String drawPoints1,
    required String venue,
    required String team1,
    required String team2,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String scorekeeperEmail,
  }) async {
    try {
      // Build the Schedule object with the updated fields.
      Schedule schedule = Schedule(
        date: date,
        starttime: startTime,
        endtime: endTime,
        venue: venue,
      );

      // Initialize the scoreboard with 0-0 for both teams.
      Scoreboard scoreboard = Scoreboard(
        teamScores: {
          team1: 0,
          team2: 0,
        },
      );
      int winPoints = int.tryParse(winPoints1) ?? 0;
      int losePoints = int.tryParse(losePoints1) ?? 0;
      int drawPoints = int.tryParse(drawPoints1) ?? 0;

      // Default status and verdict
      String status = 'upcoming';
      String verdict = 'to be decided';
      int statusPriority = 1;
      // Create the teams list
      List<String> teams = [team1, team2];

      // Build the Match object
      Match newMatch = Match(
        tournamentId: tournamentId,
        sport: sport,
        gender: gender,
        winpoints: winPoints,
        losepoints: losePoints,
        drawpoints: drawPoints,
        scoreboard: scoreboard,
        teams: teams,
        schedule: schedule,
        status: status,
        verdict: verdict,
        statusPriority: statusPriority,
        scorekeeperEmail: scorekeeperEmail,
      );

      // Create a new document in the 'matches' collection
      DocumentReference docRef = _firestore.collection('matches').doc();

      // Save the Match data to Firestore
      await docRef.set(newMatch.toMap());

      // Return the newly created document's ID
      return docRef.id;
    } catch (e) {
      print('Error creating match: $e');
      return null;
    }
  }

  Future<String?> createCricketMatch({
    required String tournamentId,
    required String sport,
    required String gender,
    required String venue,
    required String winPoints1,
    required String losePoints1,
    required String drawPoints1,
    required String team1,
    required String team2,
    required DateTime date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String scorekeeperEmail,
  }) async {
    try {
      // Retrieve the tournament doc to extract the tournament name.
      DocumentSnapshot tournamentSnap =
          await _firestore.collection('tournaments').doc(tournamentId).get();
      if (!tournamentSnap.exists) {
        print("Tournament document not found for ID: $tournamentId");
        return null;
      }

      int winPoints = int.tryParse(winPoints1) ?? 0;
      int losePoints = int.tryParse(losePoints1) ?? 0;
      int drawPoints = int.tryParse(drawPoints1) ?? 0;

      // Create a Schedule instance.
      Schedule schedule = Schedule(
        date: date,
        starttime: startTime,
        endtime: endTime,
        venue: venue,
      );
      List<String> teams = [team1, team2];
      // Initialize the cricket-specific scoreboard.
      // Here, we create a map for cricket stats for each team.
      Map<String, Map<String, dynamic>> cricketStats = {
        team1: {
          "runs": 0,
          "wickets": 0,
          "overs": 0.0,
        },
        team2: {
          "runs": 0,
          "wickets": 0,
          "overs": 0.0,
        }
      };
      CricketScoreboard cricketScoreboard =
          CricketScoreboard(teamStats: cricketStats);

      // Set default match properties.
      String status = "upcoming";
      String verdict = "to be decided";
      int statusPriority = 1; // e.g., 0 = live, 1 = upcoming, 2 = ended

      // Create the Match instance.
      // Note: In your Match model, the scoreboard field is typed as dynamic (or you use conditional parsing)
      // so that if sport == Cricket you can pass a CricketScoreboard.
      Match newMatch = Match(
        tournamentId: tournamentId,
        sport: sport,
        gender: gender,
        winpoints: winPoints,
        losepoints: losePoints,
        drawpoints: drawPoints,
        scoreboard: cricketScoreboard,
        teams: teams,
        schedule: schedule,
        status: status,
        verdict: verdict,
        statusPriority: statusPriority,
        scorekeeperEmail: scorekeeperEmail,
      );

      // Save the match document in the "matches" collection.
      DocumentReference docRef = _firestore.collection('matches').doc();
      await docRef.set(newMatch.toMap());

      return docRef.id;
    } catch (e) {
      print("Error creating cricket match: $e");
      return null;
    }
  }

  // these functions return bool telling the user if status was updated or not
  Future<bool> startMatch(String matchId) async {
    try {
      await _firestore.collection('matches').doc(matchId).update({
        'status': 'live',
        'statusPriority': 0,
      });
      return true; // Indicate success
    } catch (e) {
      print('Error starting match: $e');
      return false; // Indicate failure
    }
  }

  /// Set the match status to "end" (or "ended").
  Future<bool> endMatch(String matchId) async {
    try {
      // Step A: Retrieve the match document
      PointsService pointsService = PointsService();
      DocumentSnapshot matchSnap =
          await _firestore.collection('matches').doc(matchId).get();

      if (!matchSnap.exists) {
        print("Match doc not found for ID: $matchId");
        return false;
      }

      Map<String, dynamic> matchData = matchSnap.data() as Map<String, dynamic>;
      String tournamentId = matchData['tournament'] ?? '';
      String sport = matchData['sport'] ?? 'unknown_sport';

      // e.g. ["teamAId", "teamBId"]
      List<String> teamIds = List<String>.from(matchData['teams'] ?? []);
      if (teamIds.length < 2) {
        print("Not enough teams to finalize match $matchId");
        return false;
      }

      // scoreboard.teamScores: e.g. { "teamAId": 3, "teamBId": 1 }
      Map<String, dynamic> scoreboard = matchData['scoreboard'] ?? {};
      Map<String, dynamic> teamScores =
          Map<String, dynamic>.from(scoreboard['teamScores'] ?? {});

      // e.g., 2 for a win, 0 for a loss, 1 for a draw (or fetch from Tournament doc)
      int winPoints = matchData['winPoints'] ?? 2;
      int losePoints = matchData['losePoints'] ?? 0;
      int drawPoints = matchData['drawPoints'] ?? 1;

      // Step B: Fetch the contingents for each team
      // For simplicity, assume exactly 2 teams:
      String contingentA = teamIds[0];
      String contingentB = teamIds[1];

      int scoreA = teamScores[contingentA] ?? 0;
      int scoreB = teamScores[contingentB] ?? 0;

      // Step C: Determine winner/draw
      String verdict;
      if (scoreA > scoreB) {
        verdict = "$contingentA won"; // the winner is ContingentA
      } else if (scoreB > scoreA) {
        verdict = "$contingentB won"; // the winner is ContingentB
      } else {
        verdict = "draw";
      }

      // Step D: Update match doc with verdict and status
      await _firestore.collection('matches').doc(matchId).update({
        'verdict': verdict,
        'status': 'results',
        'statusPriority': 2,
      });

      // Step E: Update points table for these contingents
      // We create a doc ID like "sport_football"
      String sportDocId = "sport_${sport.replaceAll(' ', '_').toLowerCase()}";

      await pointsService.updatePointsTable(
        tournamentId: tournamentId,
        sportDocId: sportDocId,
        contingentA: contingentA,
        contingentB: contingentB,
        scoreA: scoreA,
        scoreB: scoreB,
        winPoints: winPoints,
        losePoints: losePoints,
        drawPoints: drawPoints,
      );

      print("Match $matchId finalized. Winner/draw: $verdict");
      return true;
    } catch (e) {
      print("Error finalizing match: $e");
      return false;
    }
  }

  double convertOversStringToDouble(String oversString) {
    // If there's no dot, parse it as full overs.
    if (!oversString.contains('.')) {
      return double.tryParse(oversString) ?? 0.0;
    }
    List<String> parts = oversString.split('.');
    int fullOvers = int.tryParse(parts[0]) ?? 0;
    int balls = int.tryParse(parts[1]) ?? 0;
    // In cricket, number of balls should be less than 6.
    if (balls >= 6) {
      // If balls >= 6, adjust by taking modulo (or you can choose to handle it as an error).
      balls = balls % 6;
    }
    return fullOvers + (balls / 6);
  }

  Future<bool> endCricketMatch(String matchId) async {
    try {
      PointsService pointsService = PointsService();
      // 1. Retrieve the match document.
      DocumentSnapshot matchSnap =
          await _firestore.collection('matches').doc(matchId).get();
      if (!matchSnap.exists) {
        print("Match not found for ID: $matchId");
        return false;
      }
      Map<String, dynamic> matchData = matchSnap.data() as Map<String, dynamic>;

      // 2. Ensure that the match is a cricket match.
      String sport = (matchData['sport'] ?? '').toString();
      if (sport.toLowerCase() != 'cricket') {
        print("Match $matchId is not a cricket match.");
        return false;
      }

      // 3. Extract tournament ID and team names from the match.
      String tournamentId = matchData['tournamentId'] ?? '';
      List<String> teamNames = List<String>.from(matchData['teams'] ?? []);
      if (teamNames.length < 2) {
        print("Not enough teams in match $matchId");
        return false;
      }
      String team1Name = teamNames[0];
      String team2Name = teamNames[1];

      // 4. Retrieve the cricket scoreboard from the match document.
      // Expected structure:
      // "scoreboard": {
      //    "Team A": { "runs": int, "wickets": int, "overs": double },
      //    "Team B": { "runs": int, "wickets": int, "overs": double }
      // }
      Map<String, dynamic> scoreboard =
          Map<String, dynamic>.from(matchData['scoreboard'] ?? {});

      // Extract runs for each team. (Other fields like wickets or overs are in scoreboard as well.)
      int team1Runs = (scoreboard[team1Name]?["runs"] ?? 0) as int;
      int team2Runs = (scoreboard[team2Name]?["runs"] ?? 0) as int;
      int team1Wickets = (scoreboard[team1Name]?["wickets"] ?? 0) as int;
      int team2Wickets = (scoreboard[team2Name]?["wickets"] ?? 0) as int;
      String team1Overs = (scoreboard[team1Name]?["overs"] ?? "0.0");
      String team2Overs = (scoreboard[team2Name]?["overs"] ?? "0.0");
      double team1OversDouble, team2OversDouble;
      if (team1Wickets == 10) {
        team1OversDouble = 20;
      } else {
        team1OversDouble = convertOversStringToDouble(team1Overs);
      }
      if (team2Wickets == 10) {
        team2OversDouble = 20;
      } else {
        team2OversDouble = convertOversStringToDouble(team2Overs);
      }

      // 5. Determine the match verdict (winner or draw).
      String verdict;
      if (team1Runs > team2Runs) {
        verdict = team1Name;
      } else if (team2Runs > team1Runs) {
        verdict = team2Name;
      } else {
        verdict = "draw";
      }

      // 6. Update the match document: set status to 'ended', statusPriority to 2, and verdict.
      await _firestore.collection('matches').doc(matchId).update({
        'status': 'ended',
        'statusPriority': 2,
        'verdict': verdict,
      });

      // 7. Retrieve the points distribution parameters from the match doc.
      // These could be stored in the match doc or extracted from the tournament doc.
      int winPoints = matchData['winpoints'] ?? 2;
      int losePoints = matchData['losepoints'] ?? 0;
      int drawPoints = matchData['drawpoints'] ?? 1;

      // 8. Prepare the data to update the cricket points table.
      // For cricket, we pass the entire cricket scoreboard, the list of contingents (team names),
      // and the points distribution.
      await pointsService.updateCricketPointsTable(
        tournamentId: tournamentId,
        team1Name: team1Name,
        team1Runs: team1Runs,
        team1Overs: team1OversDouble,
        team2Name: team2Name,
        team2Runs: team2Runs,
        team2Overs: team2OversDouble,
        winPoints: winPoints,
        losePoints: losePoints,
        drawPoints: drawPoints,
      );

      return true;
    } catch (e) {
      print("Error finalizing cricket match: $e");
      return false;
    }
  }
  /// Ends the specified sport by:
  /// 1) Fetching the tournament doc (to get gold/silver/bronze medal points).
  /// 2) Retrieving the sport's points table doc (e.g. "sport_football").
  /// 3) Sorting contingents by points desc, then goalDifference desc.
  /// 4) Awarding gold, silver, bronze to the top 3.
  /// 5) Updating the "general" doc in pointsTables to increment medal counts & points.
  ///
  /// [tournamentId]: Firestore doc ID of the tournament.
  /// [sportName]: e.g. "Football" (used to build the doc ID "sport_football").
  ///
  /// Returns `true` if successful, otherwise `false`.
  Future<bool> endSport({
    required String tournamentId,
    required String sportName,
  }) async {
    try {
      // 1) Fetch the tournament doc for medal point distribution
      DocumentSnapshot tourneySnap =
          await _firestore.collection('tournaments').doc(tournamentId).get();
      if (!tourneySnap.exists) {
        print("Tournament not found: $tournamentId");
        return false;
      }
      Map<String, dynamic> tourneyData =
          tourneySnap.data() as Map<String, dynamic>;
      int goldMedalPoints = tourneyData['goldMedalPoints'] ?? 0;
      int silverMedalPoints = tourneyData['silverMedalPoints'] ?? 0;
      int bronzeMedalPoints = tourneyData['bronzeMedalPoints'] ?? 0;

      // 2) Retrieve the sport's points table doc
      String sportDocId = _buildSportDocId(sportName);
      DocumentSnapshot sportSnap = await _firestore
          .collection('tournaments')
          .doc(tournamentId)
          .collection('pointsTables')
          .doc(sportDocId)
          .get();
      if (!sportSnap.exists) {
        print("Sport doc not found: $sportDocId in tournament $tournamentId");
        return false;
      }

      Map<String, dynamic> sportData = sportSnap.data() as Map<String, dynamic>;
      Map<String, dynamic> standingsMap =
          Map<String, dynamic>.from(sportData['standings'] ?? {});
      if (standingsMap.isEmpty) {
        print("No standings found for sport: $sportName");
        return false;
      }

      // 3) Convert standings to a list and sort them
      List<Map<String, dynamic>> sortedStandings =
          _parseAndSortStandings(standingsMap);

      // 4) Determine the top 3 medal winners (if available)
      List<Map<String, dynamic>> medalWinners = _getTopThreeContingents(
        sortedStandings,
        goldMedalPoints,
        silverMedalPoints,
        bronzeMedalPoints,
      );
      if (medalWinners.isEmpty) {
        print("Less than 1 contingent found in $sportName standings.");
        return true; // Not an error, just no medals to award
      }

      // 5) Build the Firestore update map for awarding medals in the "general" doc
      Map<String, dynamic> updateMap = _buildMedalsUpdateMap(medalWinners);

      // 6) Apply the update to the "general" doc
      DocumentReference generalDocRef = _firestore
          .collection('tournaments')
          .doc(tournamentId)
          .collection('pointsTables')
          .doc('general');

      await generalDocRef.update(updateMap);

      print(
          "Sport '$sportName' ended. Medals awarded to top 3 in tournament $tournamentId.");
      return true;
    } catch (e) {
      print("Error ending sport $sportName: $e");
      return false;
    }
  }

  /// Helper to build the doc ID for a given sport (e.g. "Football" => "sport_football")
  String _buildSportDocId(String sportName) {
    return "sport_${sportName.replaceAll(' ', '_').toLowerCase()}";
  }

  /// Converts the standings map into a list of { "contingentId", "points", "goalDifference" }
  /// and sorts them descending by points, then by goalDifference.
  List<Map<String, dynamic>> _parseAndSortStandings(
      Map<String, dynamic> standingsMap) {
    List<Map<String, dynamic>> list = [];
    standingsMap.forEach((contingentId, stats) {
      final statsMap = stats as Map<String, dynamic>;
      list.add({
        'contingentId': contingentId,
        'points': statsMap['points'] ?? 0,
        'goalDifference': statsMap['goalDifference'] ?? 0,
      });
    });

    // Sort descending by points, then by goalDifference
    list.sort((a, b) {
      int pointsA = a['points'];
      int pointsB = b['points'];
      if (pointsB != pointsA) {
        return pointsB - pointsA; // descending by points
      }
      int gdA = a['goalDifference'];
      int gdB = b['goalDifference'];
      return gdB - gdA; // descending by goalDifference
    });

    return list;
  }

  /// Extracts the top 3 contingents (if available) and maps them to
  /// [ { "contingentId": X, "medal": "gold", "points": goldMedalPoints }, ... ]
  List<Map<String, dynamic>> _getTopThreeContingents(
    List<Map<String, dynamic>> sortedStandings,
    int goldPoints,
    int silverPoints,
    int bronzePoints,
  ) {
    List<Map<String, dynamic>> medalWinners = [];

    if (sortedStandings.isNotEmpty) {
      medalWinners.add({
        'contingentId': sortedStandings[0]['contingentId'],
        'medal': 'gold',
        'points': goldPoints,
      });
    }
    if (sortedStandings.length > 1) {
      medalWinners.add({
        'contingentId': sortedStandings[1]['contingentId'],
        'medal': 'silver',
        'points': silverPoints,
      });
    }
    if (sortedStandings.length > 2) {
      medalWinners.add({
        'contingentId': sortedStandings[2]['contingentId'],
        'medal': 'bronze',
        'points': bronzePoints,
      });
    }

    return medalWinners;
  }

  /// Builds a Firestore update map that increments:
  ///   standings.<contingentId>.<medal> by 1  (e.g. gold, silver, bronze)
  ///   standings.<contingentId>.points by [medalPoints]
  Map<String, dynamic> _buildMedalsUpdateMap(
      List<Map<String, dynamic>> medalWinners) {
    Map<String, dynamic> updateMap = {};
    for (var winner in medalWinners) {
      String contId = winner['contingentId'];
      String medal = winner['medal'];
      int medalPoints = winner['points'];

      // e.g. "standings.ContingentA.gold" => FieldValue.increment(1)
      // e.g. "standings.ContingentA.points" => FieldValue.increment(medalPoints)
      updateMap['standings.$contId.$medal'] = FieldValue.increment(1);
      updateMap['standings.$contId.points'] = FieldValue.increment(medalPoints);
    }
    return updateMap;
  }

  /// Streams all matches for [tournamentId], sorted by statusPriority (0 -> 1 -> 2).
  Stream<QuerySnapshot<Map<String, dynamic>>> getMatchesForTournament(
      String tournamentId) {
    return _firestore
        .collection('matches')
        .where('tournamentId', isEqualTo: tournamentId)
        .orderBy('statusPriority')
        .snapshots();
  }

//returns a bool if the score was updated or not
  Future<bool> updateMatchScore({
    required String matchId,
    required int scoreTeam1,
    required int scoreTeam2,
  }) async {
    try {
      // 1. Get the match document
      final docRef = _firestore.collection('matches').doc(matchId);
      final snapshot = await docRef.get();

      // 2. Check if the match document exists
      if (!snapshot.exists) {
        print('Match not found for ID: $matchId');
        return false;
      }

      // 3. Extract the teams array
      final data = snapshot.data() as Map<String, dynamic>;
      final List<String> teams = List<String>.from(data['teams'] ?? []);

      // 4. Ensure we have at least two teams
      if (teams.length < 2) {
        print('Not enough teams to update scores in match: $matchId');
        return false;
      }

      // 5. Update the scores for teams[0] and teams[1] in the scoreboard
      await docRef.update({
        'scoreboard.teamScores.${teams[0]}': scoreTeam1,
        'scoreboard.teamScores.${teams[1]}': scoreTeam2,
      });

      return true;
    } catch (e) {
      print('Error updating match scores: $e');
      return false;
    }
  }

  Future<bool> updateCricketScoreboard({
    required String matchId,
    required int team1Runs,
    required int team1Wickets,
    required String team1Overs,
    required int team2Runs,
    required int team2Wickets,
    required String team2Overs,
  }) async {
    try {
      // Retrieve the match document by matchId.
      DocumentSnapshot matchSnap =
          await _firestore.collection('matches').doc(matchId).get();
      if (!matchSnap.exists) {
        print("Match not found for ID: $matchId");
        return false;
      }

      // Cast document data to Map
      Map<String, dynamic> matchData = matchSnap.data() as Map<String, dynamic>;

      // Extract team names from the 'teams' field.
      List<String> teams = List<String>.from(matchData['teams'] ?? []);
      if (teams.length < 2) {
        print("Not enough teams in match $matchId");
        return false;
      }
      String team1Name = teams[0];
      String team2Name = teams[1];

      // Update the scoreboard with new absolute values.
      // This does a direct set (not an increment).
      await _firestore.collection('matches').doc(matchId).update({
        'scoreboard.$team1Name.runs': team1Runs,
        'scoreboard.$team1Name.wickets': team1Wickets,
        'scoreboard.$team1Name.overs': team1Overs,
        'scoreboard.$team2Name.runs': team2Runs,
        'scoreboard.$team2Name.wickets': team2Wickets,
        'scoreboard.$team2Name.overs': team2Overs,
      });

      return true;
    } catch (e) {
      print("Error updating cricket scoreboard: $e");
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMatchesForScorekeeper(
      String scorekeeperEmail) {
    return _firestore
        .collection('matches')
        .where('scorekeeperEmail', isEqualTo: scorekeeperEmail)
        .where('statusPriority', isLessThan: 2)
        .orderBy('statusPriority')
        .snapshots();
  }

  Future<bool> deleteMatch(String matchId) async {
    try {
      await _firestore.collection('matches').doc(matchId).delete();
      return true; // Indicate success
    } catch (e) {
      print('Error deleting match: $e');
      return false; // Indicate failure
    }
  }
}
