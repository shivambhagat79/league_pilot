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

  /// Streams all "sport_*" docs from `/tournaments/{tournamentId}/pointsTables`
  /// in real time. For each doc:
  /// - We parse its 'standings' map,
  /// - Filter out contingents with matchesPlayed == 0,
  /// - Sort by points desc, then goalDifference desc,
  /// - Return a list of maps, each containing all stats (wins, losses, draws, etc.).
  ///
  /// The returned stream emits a Map<docId, List<Map<String, dynamic>>>, where
  /// docId might be "sport_football" or "sport_basketball", and the List
  /// contains sub-maps of { "contingentId", "wins", "losses", "draws", "points", ... }.
  Stream<Map<String, List<Map<String, dynamic>>>> streamAllSportsTables(
    String tournamentId,
  ) {
    return _firestore
        .collection('tournaments')
        .doc(tournamentId)
        .collection('pointsTables')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      // We'll accumulate results in a map: { "sport_football": [ {...}, {...} ], ... }
      final Map<String, List<Map<String, dynamic>>> allSports = {};

      for (final doc in snapshot.docs) {
        final docId = doc.id;

        // Skip "general" doc or anything that doesn't match your naming scheme
        if (docId == 'general' || !docId.startsWith('sport_')) {
          continue;
        }

        // This doc is a sport doc, e.g. "sport_football"
        final data = doc.data() as Map<String, dynamic>;
        final standingsMap = data['standings'] ?? {};

        // Convert the standings map into a list of sub-maps
        List<Map<String, dynamic>> standingsList = [];

        (standingsMap as Map<String, dynamic>)
            .forEach((contingentId, statsAny) {
          // statsAny is something like { "wins": 3, "losses": 1, ... }
          final stats = statsAny as Map<String, dynamic>;

          // Extract all the fields we care about
          int wins = stats['wins'] ?? 0;
          int losses = stats['losses'] ?? 0;
          int draws = stats['draws'] ?? 0;
          int points = stats['points'] ?? 0;
          int goalDiff = stats['goalDifference'] ?? 0;
          int matchesPlayed = stats['matchesPlayed'] ?? 0;

          // Only include contingents that have played at least 1 match
          if (matchesPlayed > 0) {
            standingsList.add({
              'contingentId': contingentId,
              'wins': wins,
              'losses': losses,
              'draws': draws,
              'points': points,
              'goalDifference': goalDiff,
              'matchesPlayed': matchesPlayed,
            });
          }
        });

        // Sort the list by points desc, then goalDifference desc
        standingsList.sort((a, b) {
          int pA = a['points'];
          int pB = b['points'];
          if (pB != pA) {
            return pB - pA; // descending by points
          }
          int gdA = a['goalDifference'];
          int gdB = b['goalDifference'];
          return gdB - gdA; // descending by GD
        });

        // Store in the final map
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
}
