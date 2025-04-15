import 'package:cloud_firestore/cloud_firestore.dart';
// for TimeOfDay

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
    }
    await _incrementField(
        tournamentId, sportDocId, contingentA, 'matchesPlayed', 1);
    await _incrementField(
        tournamentId, sportDocId, contingentB, 'matchesPlayed', 1);

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

  Future<void> updateCricketPointsTable({
    required String tournamentId,
    required String team1Name,
    required int team1Runs,
    required double team1Overs,
    required String team2Name,
    required int team2Runs,
    required double team2Overs,
    required int winPoints,
    required int losePoints,
    required int drawPoints,
  }) async {
    String cricketDocId = "sport_cricket";
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('tournaments')
        .doc(tournamentId)
        .collection('pointsTables')
        .doc(cricketDocId);

    // 1. Update cumulative statistics for both teams:
    // For team1:
    await docRef.update({
      'standings.$team1Name.matchesPlayed': FieldValue.increment(1),
      'standings.$team1Name.totalRunsScored': FieldValue.increment(team1Runs),
      'standings.$team1Name.totalRunsConceded': FieldValue.increment(team2Runs),
      'standings.$team1Name.oversPlayed': FieldValue.increment(team1Overs),
      'standings.$team1Name.oversBowled': FieldValue.increment(team2Overs),
    });
    // For team2:
    await docRef.update({
      'standings.$team2Name.matchesPlayed': FieldValue.increment(1),
      'standings.$team2Name.totalRunsScored': FieldValue.increment(team2Runs),
      'standings.$team2Name.totalRunsConceded': FieldValue.increment(team1Runs),
      'standings.$team2Name.oversPlayed': FieldValue.increment(team2Overs),
      'standings.$team2Name.oversBowled': FieldValue.increment(team1Overs),
    });

    // 2. Determine match result and update wins/losses/draws and points.
    if (team1Runs > team2Runs) {
      // Team1 wins, team2 loses.
      await docRef.update({
        'standings.$team1Name.wins': FieldValue.increment(1),
        'standings.$team1Name.points': FieldValue.increment(winPoints),
        'standings.$team2Name.losses': FieldValue.increment(1),
        'standings.$team2Name.points': FieldValue.increment(losePoints),
      });
    } else if (team2Runs > team1Runs) {
      // Team2 wins, team1 loses.
      await docRef.update({
        'standings.$team2Name.wins': FieldValue.increment(1),
        'standings.$team2Name.points': FieldValue.increment(winPoints),
        'standings.$team1Name.losses': FieldValue.increment(1),
        'standings.$team1Name.points': FieldValue.increment(losePoints),
      });
    } else {
      // It's a draw.
      await docRef.update({
        'standings.$team1Name.draws': FieldValue.increment(1),
        'standings.$team1Name.points': FieldValue.increment(drawPoints),
        'standings.$team2Name.draws': FieldValue.increment(1),
        'standings.$team2Name.points': FieldValue.increment(drawPoints),
      });
    }

    // 3. Recalculate net run rate for each team.
    DocumentSnapshot snap = await docRef.get();
    if (snap.exists) {
      Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
      Map<String, dynamic> standings =
          Map<String, dynamic>.from(data['standings'] ?? {});

      double computeNRR(Map<String, dynamic> stats) {
        int totalRunsScored = stats['totalRunsScored'] ?? 0;
        int totalRunsConceded = stats['totalRunsConceded'] ?? 0;
        double oversPlayed = (stats['oversPlayed'] ?? 0).toDouble();
        double oversBowled = (stats['oversBowled'] ?? 0).toDouble();
        if (oversPlayed > 0 && oversBowled > 0) {
          return (totalRunsScored / oversPlayed) -
              (totalRunsConceded / oversBowled);
        }
        return 0.0;
      }

      Map<String, dynamic> team1Stats =
          Map<String, dynamic>.from(standings[team1Name] ?? {});
      Map<String, dynamic> team2Stats =
          Map<String, dynamic>.from(standings[team2Name] ?? {});

      double team1NRR = computeNRR(team1Stats);
      double team2NRR = computeNRR(team2Stats);

      await docRef.update({
        'standings.$team1Name.netRunRate': team1NRR,
        'standings.$team2Name.netRunRate': team2NRR,
      });
    }
  }

  Stream<Map<String, List<Map<String, dynamic>>>> streamAllSportsTables(
      String tournamentId) {
    return FirebaseFirestore.instance
        .collection('tournaments')
        .doc(tournamentId)
        .collection('pointsTables')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      // Final map: key is sport doc ID (e.g., "sport_football"), value is a sorted list of contingent stats.
      final Map<String, List<Map<String, dynamic>>> allSports = {};

      for (final doc in snapshot.docs) {
        final docId = doc.id;

        // Skip the "general" table and any document not starting with "sport_"
        if (docId == 'general' || !docId.startsWith('sport_')) {
          continue;
        }

        // Fetch data from document.
        final data = doc.data() as Map<String, dynamic>;
        final standingsMap = data['standings'] as Map<String, dynamic>? ?? {};

        // Convert the standings map to a list of maps.
        List<Map<String, dynamic>> standingsList = [];
        standingsMap.forEach((contingentName, statsAny) {
          if (statsAny is Map) {
            // Copy the data into a new map.
            Map<String, dynamic> contingentData =
                Map<String, dynamic>.from(statsAny);
            // Add the contingent name (from the key) to the data.
            contingentData['contingentName'] = contingentName;
            // Ensure essential fields exist.
            contingentData['matchesPlayed'] =
                contingentData['matchesPlayed'] ?? 0;
            contingentData['points'] = contingentData['points'] ?? 0;
            contingentData['wins'] = contingentData['wins'] ?? 0;
            contingentData['losses'] = contingentData['losses'] ?? 0;
            contingentData['draws'] = contingentData['draws'] ?? 0;

            // For cricket, use net run rate; for others, use goalDifference.
            if (docId == 'sport_cricket') {
              double nrr = contingentData['netRunRate']?.toDouble() ?? 0.0;
              contingentData['netRunRate'] = nrr;
              // Remove goalDifference if present.
              contingentData.remove('goalDifference');
            } else {
              int goalDiff = contingentData['goalDifference'] ?? 0;
              contingentData['goalDifference'] = goalDiff;
              // Remove netRunRate if present.
              contingentData.remove('netRunRate');
            }

            // Only include if the contingent has played at least one match.
            int matchesPlayed = contingentData['matchesPlayed'];
            if (matchesPlayed > 0) {
              standingsList.add(contingentData);
            }
          }
        });

        // Sort the standings list using sport-specific criteria.
        if (docId == 'sport_cricket') {
          // For cricket: sort by points descending, then by net run rate descending.
          standingsList.sort((a, b) {
            int pointsA = a['points'] ?? 0;
            int pointsB = b['points'] ?? 0;
            if (pointsB != pointsA) return pointsB - pointsA;
            double nrrA = a['netRunRate'] ?? 0.0;
            double nrrB = b['netRunRate'] ?? 0.0;
            return nrrB.compareTo(nrrA);
          });
        } else {
          // For non-cricket sports: sort by points descending, then by goal difference descending.
          standingsList.sort((a, b) {
            int pointsA = a['points'] ?? 0;
            int pointsB = b['points'] ?? 0;
            if (pointsB != pointsA) return pointsB - pointsA;
            int gdA = a['goalDifference'] ?? 0;
            int gdB = b['goalDifference'] ?? 0;
            return gdB - gdA;
          });
        }

        allSports[docId] = standingsList;
      }

      return allSports;
    });
  }

  Stream<List<Map<String, dynamic>>> streamGeneralTable(String tournamentId) {
    return _firestore
        .collection('tournaments')
        .doc(tournamentId)
        .collection('pointsTables')
        .doc('general')
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      // If the doc doesn't exist, return an empty list
      if (!snapshot.exists) {
        return [];
      }

      // Parse the doc data
      final data = snapshot.data() as Map<String, dynamic>;
      final standingsMap = data['standings'] ?? {};

      // Convert the map to a list of sub-maps
      List<Map<String, dynamic>> list = [];
      (standingsMap as Map<String, dynamic>).forEach((contingentId, statsAny) {
        final stats = statsAny as Map<String, dynamic>;
        int gold = stats['gold'] ?? 0;
        int silver = stats['silver'] ?? 0;
        int bronze = stats['bronze'] ?? 0;
        int points = stats['points'] ?? 0;

        // We won't filter anyone out here; all contingents are included
        list.add({
          'contingentId': contingentId,
          'gold': gold,
          'silver': silver,
          'bronze': bronze,
          'points': points,
        });
      });

      // Sort by gold desc, then silver desc, then bronze desc
      list.sort((a, b) {
        if (b['gold'] != a['gold']) {
          return b['gold'] - a['gold'];
        }
        if (b['silver'] != a['silver']) {
          return b['silver'] - a['silver'];
        }
        return b['bronze'] - a['bronze'];
      });

      return list;
    });
  }

  Future<List<Map<String, dynamic>>> getSportTable(
      String tournamentId, String sport) async {
    final snapshot = await _firestore
        .collection('tournaments')
        .doc(tournamentId)
        .collection('pointsTables')
        .doc("sport_${sport.toLowerCase().replaceAll(' ', '_')}")
        .get();

    if (!snapshot.exists) {
      return [];
    }

    final data = snapshot.data() as Map<String, dynamic>;
    final standingsMap = data['standings'] ?? {};

    List<Map<String, dynamic>> list = [];

    (standingsMap as Map<String, dynamic>).forEach((contingentId, statsAny) {
      final stats = statsAny as Map<String, dynamic>;
      int wins = stats['wins'] ?? 0;
      int losses = stats['losses'] ?? 0;
      int draws = stats['draws'] ?? 0;
      int points = stats['points'] ?? 0;
      int goalDiff = stats['goalDifference'] ?? 0;
      int matchesPlayed = stats['matchesPlayed'] ?? 0;
      double nrr = stats['netRunRate']?.toDouble() ?? 0.0;

      list.add({
        'contingentId': contingentId,
        'wins': wins,
        'losses': losses,
        'draws': draws,
        'points': points,
        'goalDifference': goalDiff,
        'matchesPlayed': matchesPlayed,
        'netRunRate': nrr,
      });
    });

    list.sort((a, b) {
      if (b['points'] != a['points']) {
        return b['points'] - a['points'];
      }
      if (sport == 'Cricket') {
        return b['netRunRate'].compareTo(a['netRunRate']);
      }
      return b['goalDifference'] - a['goalDifference'];
    });

    return list;
  }
}
