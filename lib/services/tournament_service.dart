import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tournament.dart';

class TournamentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createTournament({
    required String name,
    required String hostInstitute,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> admins,
    required List<String> sports,
    required List<String> contingents,
    required String goldMedalPointsString,
    required String silverMedalPointsString,
    required String bronzeMedalPointsString,
    required String latitudeString,
    required String longitudeString,
    required String security,
    required String medical,
    required String organiser,
  }) async {
    try {
      // 2. Convert medal points strings to integers
      int goldMedalPoints = int.tryParse(goldMedalPointsString) ?? 0;
      int silverMedalPoints = int.tryParse(silverMedalPointsString) ?? 0;
      int bronzeMedalPoints = int.tryParse(bronzeMedalPointsString) ?? 0;

      // 3. Convert latitude/longitude strings to doubles
      double latitude = double.tryParse(latitudeString) ?? 0.0;
      double longitude = double.tryParse(longitudeString) ?? 0.0;

      // 4. Set the status to "active" and use an empty list for pictureUrls
      String status = "active";
      List<String> pictureUrls = [];

      // 5. Create the Tournament object
      Tournament newTournament = Tournament(
        name: name,
        hostInstitute: hostInstitute,
        startDate: startDate,
        endDate: endDate,
        admins: admins,
        sports: sports,
        contingents: contingents,
        goldMedalPoints: goldMedalPoints,
        silverMedalPoints: silverMedalPoints,
        bronzeMedalPoints: bronzeMedalPoints,
        pictureUrls: pictureUrls,
        status: status,
        latitude: latitude,
        longitude: longitude,
        security: security,
        medical: medical,
        organiser: organiser,
      );

      // 6. Create a new document in 'tournaments' collection
      DocumentReference docRef = _firestore.collection('tournaments').doc();

      // 7. Save the tournament data to Firestore
      await docRef.set(newTournament.toMap());

      // 8. Return the generated document ID
      return docRef.id;
    } catch (e) {
      print("Error creating tournament: $e");
      return null;
    }
  }

  Future<List<Map<String, String>>> getActiveTournaments() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('tournaments')
          .where('status', isEqualTo: 'active')
          .get();

      List<Map<String, String>> activeTournaments = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return {
          'tournamentId': doc.id,
          'tournamentName': data['name']?.toString() ?? '',
          'hostInstitute': data['hostInstitute']?.toString() ?? '',
        };
      }).toList();

      return activeTournaments;
      // the function will return list of maps access it using keys    tournamentId, tournamentName, hostInstitute
    } catch (e) {
      print("Error retrieving active tournaments: $e");
      return [];
    }
  }

  Future<List<String>> getContingents(String tournamentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        // If the document doesn't exist, return an empty list.
        return [];
      }

      // Cast the snapshot data to a Map
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Extract the contingents field (ensure it's a List<String>)
      List<String> contingents = List<String>.from(data['contingents'] ?? []);
      return contingents;
    } catch (e) {
      print("Error getting contingents: $e");
      return [];
    }
  }

  /// Returns a list of sports for the given tournament ID.
  Future<List<String>> getSports(String tournamentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        // If the document doesn't exist, return an empty list.
        return [];
      }

      // Cast the snapshot data to a Map
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Extract the sports field (ensure it's a List<String>)
      List<String> sports = List<String>.from(data['sports'] ?? []);
      return sports;
    } catch (e) {
      print("Error getting sports: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTournamentsByAdminEmail(
      String adminEmail) async {
    try {
      // Query tournaments where the 'admins' array contains [adminEmail]
      QuerySnapshot snapshot = await _firestore
          .collection('tournaments')
          .where('admins', arrayContains: adminEmail)
          .get();

      // Convert each document into a map with relevant fields
      List<Map<String, dynamic>> tournaments = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'tournamentId': doc.id,
          'tournamentName': data['name'] ?? '',
          'hostInstitute': data['hostInstitute'] ?? '',
        };
      }).toList();

      return tournaments;
    } catch (e) {
      print("Error retrieving tournaments for admin $adminEmail: $e");
      return [];
    }
  }
}
