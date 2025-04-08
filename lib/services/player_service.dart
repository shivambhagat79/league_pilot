import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getPlayer(String playerEmail) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('players')
          .where('email', isEqualTo: playerEmail)
          .get();

      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot playerDoc = snapshot.docs.first;
        return playerDoc.data() as Map<String, dynamic>;
      } else {
        print("Player not found for email: $playerEmail");
        return {};
      }
    } catch (e) {
      print("Error checking player existence: $e");
      return {};
    }
  }
}
