import 'package:cloud_firestore/cloud_firestore.dart';

class TournamentServiceDashboard {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<String>> getRecentMatchIdsFromTournament(
      String tournamentId) async {
    try {
      // Retrieve the tournament document by its ID
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        return [];
      }

      // Convert the document data to a Map
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Extract the matchIds list (ensure it's a List<String>)
      List<String> matchIds = List<String>.from(data['matchIds'] ?? []);
      int totalMatches = matchIds.length;

      if (totalMatches == 0) return [];

      // Determine the starting index for the last 5 entries
      int startIndex = totalMatches >= 5 ? totalMatches - 5 : 0;

      // Retrieve the last 5 (or fewer) match IDs
      List<String> recentMatches = matchIds.sublist(startIndex, totalMatches);

      // Reverse the list so that the most recent match comes first
      return recentMatches.reversed.toList();
    } catch (e) {
      print("Error retrieving recent match IDs: $e");
      return [];
    }
  }
}
