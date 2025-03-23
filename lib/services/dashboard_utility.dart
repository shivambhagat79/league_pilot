import '../models/tournament.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

// Saaransh
// changed the classname from TournamentService to DashboardService
class DashboardService {
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

  //Saaransh

  // Future<List<String>> getImagesDashboard(String tournamentId) async {
  //   try {
  //     DocumentSnapshot snapshot =
  //     await _firestore.collection('tournaments').doc(tournamentId).get();
  //
  //     if (!snapshot.exists) {
  //       return [];
  //     }
  //
  //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //
  //     List<String> images = List<String>.from(data['pictureUrls'] ?? []);
  //
  //     // Edge case: If there are no images, return an empty list
  //     if (images.isEmpty) {
  //       return [];
  //     }
  //
  //     // Edge case: If there are fewer than 6 images, return all available images
  //     if (images.length <= 6) {
  //       return images;
  //     }
  //
  //     // Shuffle the list and pick the first 6 images randomly
  //     List<String> randomImages;
  //
  //     images.shuffle(Random());
  //     randomImages = images.take(6).toList();
  //
  //     return randomImages;
  //
  //
  //   } catch(e) {
  //       print("Error retrieving Images for Tournament with Id : $tournamentId: $e");
  //       return [];
  //   }
  // }
}
