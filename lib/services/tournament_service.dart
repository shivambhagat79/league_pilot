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
    required String organiserEmail,
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
        organiserEmail: organiserEmail,
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
      // Skip cricket: handle it separately.
      if (sport.toLowerCase() == "cricket") {
        continue;
      }
      Map<String, dynamic> sportStandings = {};
      for (var contingent in contingents) {
        sportStandings[contingent] = {
          "wins": 0,
          "losses": 0,
          "draws": 0,
          "points": 0,
          "goalDifference": 0,
          "matchesPlayed": 0,
        };
      }
      // Construct document ID, e.g. "sport_football", "sport_basketball", etc.
      String docId = "sport_" + sport.replaceAll(' ', '_').toLowerCase();

      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(tournamentId)
          .collection('pointsTables')
          .doc(docId)
          .set({
        "standings": sportStandings,
      });
    }

    // 2. Initialize a dedicated points table for Cricket (if cricket is in the sports list)
    bool hasCricket = sports.any((s) => s.toLowerCase() == "cricket");
    if (hasCricket) {
      Map<String, dynamic> cricketStandings = {};
      for (var contingent in contingents) {
        cricketStandings[contingent] = {
          "matchesPlayed": 0,
          "wins": 0,
          "losses": 0,
          "draws": 0,
          "points": 0,
          // Cricket-specific fields:
          "totalRunsScored": 0,
          "totalRunsConceded": 0,
          "oversPlayed": 0.0,
          "oversBowled": 0.0,
          "netRunRate": 0.0,
        };
      }
      String cricketDocId =
          "sport_cricket"; // You may force this name for cricket.
      await FirebaseFirestore.instance
          .collection('tournaments')
          .doc(tournamentId)
          .collection('pointsTables')
          .doc(cricketDocId)
          .set({
        "standings": cricketStandings,
      });
    }
  }

  Future<String?> getTournamentId(String tournamentName) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('tournaments')
          .where('name', isEqualTo: tournamentName)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot
            .docs.first.id; // Return the first matching tournament ID
      } else {
        return null; // No tournament found with that name
      }
    } catch (e) {
      print("Error retrieving tournament ID: $e");
      return null;
    }
  }

  Future<String> getTournamentName(String tournamentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data['name']?.toString() ?? 'Unknown Tournament';
      } else {
        return 'Tournament not found';
      }
    } catch (e) {
      print("Error retrieving tournament name: $e");
      return 'Error retrieving tournament name';
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

  Future<Map<String, dynamic>> getTournamentById(String tournamentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        // If the document doesn't exist, return an empty map.
        return {};
      }

      // Convert document data to a Map
      Map<String, dynamic> tournamentData =
          snapshot.data() as Map<String, dynamic>;

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
          'status': data['status'] ?? 'unknown',
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
      // Fetch the tournament document.
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        return false;
      }

      // Cast the snapshot data to a Map.
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Retrieve the current list of sports.
      List<String> sports = List<String>.from(data['sports'] ?? []);

      // Check if the sport is already in the list.
      if (!sports.contains(sport)) {
        sports.add(sport);
        // Update Firestore with the new sports list.
        await _firestore.collection('tournaments').doc(tournamentId).update({
          'sports': sports,
        });
      }

      // Create a new points table for the sport.
      // Build a document ID based on the sport name, e.g., "sport_football"

      String sportDocId = "sport_${sport.replaceAll(' ', '_').toLowerCase()}";

      // Retrieve the list of contingents from the tournament document.
      List<String> contingents = List<String>.from(data['contingents'] ?? []);

      // Initialize the standings map with each contingent having default values.
      Map<String, dynamic> standings = {};
      for (var contingent in contingents) {
        standings[contingent] = {
          "wins": 0,
          "losses": 0,
          "draws": 0,
          "points": 0,
          "goalDifference": 0,
          "matchesPlayed": 0,
        };
      }

      // Create the points table document in the 'pointsTables' sub-collection.
      await _firestore
          .collection('tournaments')
          .doc(tournamentId)
          .collection('pointsTables')
          .doc(sportDocId)
          .set({
        "standings": standings,
      });

      return true;
    } catch (e) {
      print(
          "Error adding sport $sport to Tournament with Id $tournamentId: $e");
      return false;
    }
  }

  //Saaransh
  Future<bool> removeSportFromTournament(
      String tournamentId, String sport) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        return false;
      }

      // Cast the snapshot data to a Map.
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Retrieve the current list of sports.
      List<String> sportsList = List<String>.from(data['sports'] ?? []);

      // Check if the sport exists in the list.
      if (sportsList.contains(sport)) {
        sportsList.remove(sport);

        // Update Firestore with the modified list.
        await _firestore.collection('tournaments').doc(tournamentId).update({
          'sports': sportsList,
        });

        // Construct the sport doc ID (assuming the same convention used during addition).
        String sportDocId = "sport_${sport.replaceAll(' ', '_').toLowerCase()}";

        // Remove the points table document for that sport.
        await _firestore
            .collection('tournaments')
            .doc(tournamentId)
            .collection('pointsTables')
            .doc(sportDocId)
            .delete();

        return true; // Sport successfully removed.
      }
      return false; // Sport was not in the list.
    } catch (e) {
      print(
          "Error removing sport $sport from Tournament with Id $tournamentId: $e");
      return false;
    }
  }

  Future<bool> deleteTournament(String tournamentId) async {
    try {
      // Reference to the tournament document.
      DocumentReference tournamentRef =
          _firestore.collection('tournaments').doc(tournamentId);

      // Delete documents in the "pointsTables" subcollection.
      QuerySnapshot pointsTablesSnapshot =
          await tournamentRef.collection('pointsTables').get();
      for (DocumentSnapshot doc in pointsTablesSnapshot.docs) {
        await doc.reference.delete();
      }
      // Delete documents in the "matches" subcollection.
      QuerySnapshot matchesSnapshot =
          await tournamentRef.collection('matches').get();
      for (DocumentSnapshot doc in matchesSnapshot.docs) {
        await doc.reference.delete();
      }

      // Now delete the main tournament document.
      await tournamentRef.delete();

      return true;
    } catch (e) {
      print("Error deleting tournament with ID $tournamentId: $e");
      return false;
    }
  }

  Future<bool> endTournament(String tournamentId) async {
    try {
      await _firestore.collection('tournaments').doc(tournamentId).update({
        'status': 'result',
      });
      return true;
    } catch (e) {
      print("Error ending tournament with ID $tournamentId: $e");
      return false;
    }
  }
}
