import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player.dart'; //  Player model
import '../models/admin.dart'; //  Admin model
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
    required String tournament,
  }) async {
    try {
      // Create the user in Firebase Auth using email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Create a Player instance with extra details
      if (user == null) return null;
      Player newPlayer = Player(
        id: user.uid,
        name: name,
        email: email,
        phoneNumber: phone,
        tournamentContingent: tournamentContingent,
        tournament: tournament,
      );

      // Save additional user details in Firestore under a 'players' collection
      await _firestore.collection('players').doc(user.uid).set(newPlayer.toMap());
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<User?> registerWithEmailAndPasswordForAdmin({
    required String name,
    required String email,
    required String password,
    required String tournament,
  }) async {
    try {
      // Create the user in Firebase Auth using email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      // Create a Player instance with extra details
      if (user == null) return null;
       Admin newAdmin = Admin(
        id: user.uid,
        name: name,
        email: email,
        password: password,
        tournament: tournament,
      );

      // Save additional user details in Firestore under a 'players' collection
      await _firestore.collection('admins').doc(user.uid).set(newAdmin.toMap());
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
  Future<String?> registerPlayer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String tournamentContingent,
    required String tournament,
})async {
  // Call the original registration function
  User? user = await registerWithEmailAndPassword(
    name: name,
    email: email,
    password: password,
    phone: phone,
    tournamentContingent: tournamentContingent,
    tournament: tournament,
  );

  // If registration failed, return null
  if (user == null) return null;

  // Create and return the Admin instance
  return user.uid;
  
}
Future<String?> registerAdmin({
    required String name,
    required String email,
    required String password,
    required String tournament,
    }) async {
  // Call the original registration function
  User? user = await registerWithEmailAndPasswordForAdmin(
    name: name,
    email: email,
    password: password,
    tournament: tournament,
  );
  if (user == null) return null;
  return user.uid;
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
