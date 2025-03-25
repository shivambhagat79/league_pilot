import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart'; // for TimeOfDay
import '../models/match.dart';

class PointsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> updatePointsTable({
    required String tournamentId,
    required String sportDocId,
    required String contingentA,
    required String contingentB,
    required int scoreA,
    required int scoreB,
    required int winPoints,
    required int losePoints,
    required int drawPoints,
  }) async {
    if (scoreA == scoreB) {
      // Draw
      await _incrementField(tournamentId, sportDocId, contingentA, 'draws', 1);
      await _incrementField(tournamentId, sportDocId, contingentB, 'draws', 1);

      await _incrementField(
          tournamentId, sportDocId, contingentA, 'points', drawPoints);
      await _incrementField(
          tournamentId, sportDocId, contingentB, 'points', drawPoints);
    } else if (scoreA > scoreB) {
      // ContingentA wins
      await _incrementField(tournamentId, sportDocId, contingentA, 'wins', 1);
      await _incrementField(
          tournamentId, sportDocId, contingentA, 'points', winPoints);

      // ContingentB loses
      await _incrementField(tournamentId, sportDocId, contingentB, 'losses', 1);
      await _incrementField(
          tournamentId, sportDocId, contingentB, 'points', losePoints);
    } else {
      // ContingentB wins
      await _incrementField(tournamentId, sportDocId, contingentB, 'wins', 1);
      await _incrementField(
          tournamentId, sportDocId, contingentB, 'points', winPoints);

      // ContingentA loses
      await _incrementField(tournamentId, sportDocId, contingentA, 'losses', 1);
      await _incrementField(
          tournamentId, sportDocId, contingentA, 'points', losePoints);
      //increase the matches of teams by one   
     await _incrementField(
          tournamentId, sportDocId, contingentA, 'matchesPlayed', 1);
      await _incrementField(
          tournamentId, sportDocId, contingentB, 'matchesPlayed', 1);     
    }

    // Update goalDifference
    int goalDiffA = scoreA - scoreB;
    int goalDiffB = scoreB - scoreA;
    await _incrementField(
        tournamentId, sportDocId, contingentA, 'goalDifference', goalDiffA);
    await _incrementField(
        tournamentId, sportDocId, contingentB, 'goalDifference', goalDiffB);
  }

  /// Increments a numeric field in the sub-collection doc:
  /// /tournaments/{tournamentId}/pointsTables/{sportDocId}
  Future<void> _incrementField(
    String tournamentId,
    String sportDocId,
    String contingentId,
    String field,
    int incrementBy,
  ) async {
    await _firestore
        .collection('tournaments')
        .doc(tournamentId)
        .collection('pointsTables')
        .doc(sportDocId)
        .update({
      'standings.$contingentId.$field': FieldValue.increment(incrementBy),
    });
  }
}
