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
}
