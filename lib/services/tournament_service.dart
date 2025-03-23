import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tournament.dart';

class TournamentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createTournament({
    required String name,
    required String hostInstitute,
    required String startDateString,
    required String endDateString,
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
      // 1. Convert date strings to DateTime
      DateTime startDate = DateTime.tryParse(startDateString) ?? DateTime.now();
      DateTime endDate = DateTime.tryParse(endDateString) ?? DateTime.now();

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

      // initialize the points table for the tournament
      await initializePointsTables(
        tournamentId: docRef.id,
        contingents: contingents,
        sports: sports,
      );
      // 8. Return the generated document ID
      return docRef.id;
    } catch (e) {
      print("Error creating tournament: $e");
      return null;
    }
  }

  Future<void> initializePointsTables({
    required String tournamentId,
    required List<String> contingents,
    required List<String> sports,
  }) async {
    // 1) Initialize the "general" doc with 0 medals for each contingent
    Map<String, dynamic> generalStandings = {};
    for (var contingent in contingents) {
      generalStandings[contingent] = {
        "gold": 0,
        "silver": 0,
        "bronze": 0,
        "points": 0, // total points from medals
      };
    }

    await _firestore
        .collection('tournaments')
        .doc(tournamentId)
        .collection('pointsTables')
        .doc('general')
        .set({
      "standings": generalStandings,
    });

    // 2) For each sport, create a doc with W/L/draw for each contingent
    for (var sport in sports) {
      Map<String, dynamic> sportStandings = {};
      for (var contingent in contingents) {
        sportStandings[contingent] = {
          "wins": 0,
          "losses": 0,
          "draws": 0,
          "points": 0, // total points for that sport
        };
      }

      // Example doc ID: "sport_football"
      String docId = "sport_$sport".replaceAll(' ', '_').toLowerCase();

      await _firestore
          .collection('tournaments')
          .doc(tournamentId)
          .collection('pointsTables')
          .doc(docId)
          .set({
        "standings": sportStandings,
      });
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

  //Saaransh

  Future<Map<String, dynamic>> getTournamentById(String tournamentId) async {
    try {
      DocumentSnapshot snapshot =
      await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        // If the document doesn't exist, return an empty map.
        return {};
      }

      // Convert document data to a Map
      Map<String, dynamic> tournamentData = snapshot.data() as Map<String, dynamic>;

      return tournamentData;
    } catch (e) {
      print("Error retrieving tournament with ID $tournamentId: $e");
      return {};
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

  //Saaransh
  Future<bool> addSportToTournament(String tournamentId, String sport) async {
    try {
      DocumentSnapshot snapshot =
      await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        return false;
      }

      // Cast the snapshot data to a Map
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Retrieve the current list of sports
      List<String> sports = List<String>.from(data['sports'] ?? []);

      // Check if the sport is already in the list
      if (!sports.contains(sport)) {
        sports.add(sport);

        // Update Firestore with the new list
        await _firestore.collection('tournaments').doc(tournamentId).update({
          'sports': sports,
        });
      }

      return true;
    } catch (e) {
      print("Error adding sport $sport to Tournament with Id $tournamentId: $e");
      return false;
    }
  }

  //Saaransh
  Future<bool> removeSportFromTournament(String tournamentId, String sport) async {
    try {
      DocumentSnapshot snapshot =
      await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        return false;
      }

      // Cast the snapshot data to a Map
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Retrieve the current list of sports
      List<String> sports = List<String>.from(data['sports'] ?? []);

      // Check if the sport exists in the list
      if (sports.contains(sport)) {
        sports.remove(sport);

        // Update Firestore with the modified list
        await _firestore.collection('tournaments').doc(tournamentId).update({
          'sports': sports,
        });

        return true; // Sport successfully removed
      }

      return false; // Sport was not in the list
    } catch (e) {
      print("Error removing sport $sport from Tournament with Id $tournamentId: $e");
      return false;
    }
  }


}
