import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player.dart'; // Your Player model

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign in anonymously
  Future<User?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email, password, and additional user details
  Future<User?> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String tournamentContingent,
  }) async {
    try {
      // Create the user in Firebase Auth using email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Create a Player instance with extra details
      Player newPlayer = Player(
        name: name,
        email: email,
        phoneNumber: phone,
        tournamentContingent: tournamentContingent,
      );

      // Save additional user details in Firestore under a 'players' collection
      await _firestore
          .collection('players')
          .doc(user!.uid)
          .set(newPlayer.toMap());

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
