import 'package:cloud_firestore/cloud_firestore.dart';

//Saaransh

class GalleryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getImages(String tournamentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('tournaments').doc(tournamentId).get();

      if (!snapshot.exists) {
        return [];
      }

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      List<String> images = List<String>.from(data['pictureUrls'] ?? []);

      return images;
    } catch (e) {
      print(
          "Error retrieving Images for Tournament with Id : $tournamentId: $e");
      return [];
    }
  }

  Future<bool> addImage(String tournamentId, String imageUrl) async {
    try {
      DocumentReference tournamentRef =
          _firestore.collection('tournaments').doc(tournamentId);

      await tournamentRef.update({
        'pictureUrls': FieldValue.arrayUnion([imageUrl])
      });

      return true;
    } catch (e) {
      print("Error adding image to Tournament: $e");
      return false;
    }
  }
}
