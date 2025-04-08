import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/team.dart';

class TeamService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String?> createTeam({
    required String tournamentId,
    required String contingentName,
    required String sport,
    required String gender,
    required String captainName,
    required String captainEmail,
    required List<Map<String, String>> players,
  }) async {
    try {
      // Retrieve the tournament document to extract the tournament name.
      DocumentSnapshot tournamentSnap = await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!tournamentSnap.exists) {
        print("Tournament document not found for ID: $tournamentId");
        return null;
      }

      Map<String, dynamic> tournamentData = tournamentSnap.data() as Map<String, dynamic>;
      String tournamentName = tournamentData['name'] ?? '';

      // Create a new team instance.
      Team newTeam = Team(
        tournamentName: tournamentName,
        contingentName: contingentName,
        sport: sport,
        gender: gender,
        captainName: captainName,
        captainEmail: captainEmail,
        players: players,
      );

      // Save the team in the "teams" collection.
      DocumentReference docRef = _firestore.collection('teams').doc();
      await docRef.set(newTeam.toMap());

      return docRef.id;
    } catch (e) {
      print("Error creating team: $e");
      return null;
    }
  }
   Future<Map<String, dynamic>?> getTeam({
    required String tournamentId,
    required String contingent,
    required String sport,
  }) async {
    try {
      // Step 1: Retrieve the Tournament document using tournamentId.
      DocumentSnapshot tournamentSnap =
          await _firestore.collection('tournaments').doc(tournamentId).get();
      if (!tournamentSnap.exists) {
        print("Tournament not found for ID: $tournamentId");
        return null;
      }
      Map<String, dynamic> tournamentData =
          tournamentSnap.data() as Map<String, dynamic>;
      String tournamentName = tournamentData['name'] ?? '';

      // Step 2: Query the "teams" collection using the tournamentName,
      // contingentName, and sport.
      QuerySnapshot teamQuery = await _firestore
          .collection('teams')
          .where('tournamentName', isEqualTo: tournamentName)
          .where('contingentName', isEqualTo: contingent)
          .where('sport', isEqualTo: sport)
          .limit(1)
          .get();

      if (teamQuery.docs.isEmpty) {
        print("No team found for tournament: $tournamentName, contingent: $contingent, sport: $sport");
        return null;
      }

      // Step 3: Extract the team document.
      DocumentSnapshot teamDoc = teamQuery.docs.first;
      Map<String, dynamic> teamData = teamDoc.data() as Map<String, dynamic>;

      // Prepare a result map containing captain info and players list.
      Map<String, dynamic> result = {
        'captainName': teamData['captainName'] ?? '',
        'captainEmail': teamData['captainEmail'] ?? '',
        'players': teamData['players'] ?? [],
      };

      return result;
    } catch (e) {
      print("Error retrieving team: $e");
      return null;
    }
  }
}
