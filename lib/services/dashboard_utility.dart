// changed the classname from TournamentService to DashboardService
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../models/match.dart';

class DashboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Match>> getRecentMatches(String tournamentId) async {
    try {
      // Query matches for the given tournament, order by schedule.date descending
      // and limit to 5.
      QuerySnapshot snapshot = await _firestore
          .collection('matches')
          .where('tournament', isEqualTo: tournamentId)
          .orderBy('schedule.date', descending: true)
          .limit(5)
          .get();

      // Convert each document into a Match object
      List<Match> matches = snapshot.docs.map((doc) {
        return Match.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();

      return matches;
    } catch (e) {
      print('Error retrieving recent matches: $e');
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
