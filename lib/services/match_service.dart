import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // for TimeOfDay
import '../models/match.dart';
import '../models/schedule.dart';
import '../models/scoreboard.dart';

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
    required String tournament,
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
        tournament: tournament,
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
      await _firestore.collection('matches').doc(matchId).update({
        'status': 'results',
        'statusPriority': 2,
      });
      return true; // Indicate success
    } catch (e) {
      print('Error ending match: $e');
      return false; // Indicate failure
    }
  }

  /// Streams all matches for [tournamentId], sorted by statusPriority (0 -> 1 -> 2).
  Stream<List<Match>> getMatchesForTournament(String tournamentId) {
    return _firestore
        .collection('matches')
        .where('tournament', isEqualTo: tournamentId)
        .orderBy('statusPriority')
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        // Make sure Match.fromMap can handle doc.id if needed
        return Match.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
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
}
