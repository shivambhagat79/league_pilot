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
        'status': 'end',
      });
      return true; // Indicate success
    } catch (e) {
      print('Error ending match: $e');
      return false; // Indicate failure
    }
  }
}
