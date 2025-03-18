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
}
