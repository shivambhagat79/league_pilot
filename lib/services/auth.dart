import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player.dart'; // Player model
import '../models/admin.dart'; // Admin model

class AuthResult {
  final String? uid;
  final String message;

  AuthResult({this.uid, required this.message});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email & password
  Future<AuthResult> signInPlayer(String email, String password) async {
    try {
      // Sign in using Firebase Auth
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        return AuthResult(uid: null, message: "Sign in failed");
      }
      // Check if this UID exists in the 'players' collection
      DocumentSnapshot doc =
          await _firestore.collection('players').doc(user.uid).get();
      if (!doc.exists) {
        // The UID does not exist in players collection,
        return AuthResult(
            uid: null,
            message:
                "Invalid credentials: invalid account used on player portal");
      }
      return AuthResult(uid: user.uid, message: "Player sign in successful");
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          uid: null,
          message: e.message ??
              "Sign in failed"); // tackles specific exception like email already in use, invalid email, wrong password,etc
    } catch (e) {
      return AuthResult(
          uid: null, message: e.toString()); // tackles normal exception
    }
  }

  Future<AuthResult> signInAdmin(String email, String password) async {
    try {
      // Sign in using Firebase Auth
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        return AuthResult(uid: null, message: "Sign in failed");
      }
      // Check if this UID exists in the 'admins' collection
      DocumentSnapshot doc =
          await _firestore.collection('admins').doc(user.uid).get();
      if (!doc.exists) {
        // The UID does not exist in admins collection,
        return AuthResult(
            uid: null,
            message:
                "Invalid credentials: invalid account used on admin portal");
      }
      return AuthResult(uid: user.uid, message: "Admin sign in successful");
    } on FirebaseAuthException catch (e) {
      return AuthResult(
          uid: null,
          message: e.message ??
              "Sign in failed"); // handles specific exception like email already in use, invalid email, wrong password,etc
    } catch (e) {
      return AuthResult(
          uid: null, message: e.toString()); // tackeles normal exception
    }
  }

  // Register player with email, password, and additional details
  Future<AuthResult> signupWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String tournamentContingent,
    required String tournament,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        return AuthResult(uid: null, message: "Registration failed");
      }
      // Create a Player instance with extra details
      Player newPlayer = Player(
        id: user.uid,
        name: name,
        email: email,
        phoneNumber: phone,
        tournamentContingent: tournamentContingent,
        tournament: tournament,
      );

      // Save additional player details in Firestore under the 'players' collection
      await _firestore
          .collection('players')
          .doc(user.uid)
          .set(newPlayer.toMap());
      return AuthResult(
          uid: user.uid, message: "Player registration successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return AuthResult(uid: null, message: "The email is already in use");
      }
      return AuthResult(uid: null, message: e.message ?? "Registration failed");
    } catch (e) {
      return AuthResult(uid: null, message: e.toString());
    }
  }

  // Register admin with email, password, and additional details
  Future<AuthResult> signupWithEmailAndPasswordAdmin({
    required String name,
    required String email,
    required String password,
    required String tournament,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        return AuthResult(uid: null, message: "Registration failed");
      }
      // Create an Admin instance with extra details
      Admin newAdmin = Admin(
        id: user.uid,
        name: name,
        email: email,
        password: password,
        tournament: tournament,
      );

      // Save additional admin details in Firestore under the 'admins' collection
      await _firestore.collection('admins').doc(user.uid).set(newAdmin.toMap());
      return AuthResult(
          uid: user.uid, message: "Admin registration successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return AuthResult(uid: null, message: "The email is already in use");
      }
      return AuthResult(uid: null, message: e.message ?? "Registration failed");
    } catch (e) {
      return AuthResult(uid: null, message: e.toString());
    }
  }

  Future<List<String?>> registerPlayer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String tournamentContingent,
    required String tournament,
  }) async {
    try {
      AuthResult result = await signupWithEmailAndPassword(
          name: name,
          email: email,
          password: password,
          phone: phone,
          tournamentContingent: tournamentContingent,
          tournament: tournament);
      return [result.uid, result.message];
    } catch (e) {
      return [null, e.toString()];
    }
  }

  Future<List<String?>> registerAdmin({
    required String name,
    required String email,
    required String password,
    required String tournament,
  }) async {
    try {
      AuthResult result = await signupWithEmailAndPasswordAdmin(
          name: name, email: email, password: password, tournament: tournament);
      return [result.uid, result.message];
    } catch (e) {
      return [null, e.toString()];
    }
  }

  Future<List<String?>> loginPlayer(String email, String password) async {
    try {
      AuthResult result = await signInPlayer(email, password);
      return [result.uid, result.message];
    } catch (e) {
      return [null, e.toString()];
    }
  }

  Future<List<String?>> loginAdmin(String email, String password) async {
    try {
      AuthResult result = await signInAdmin(email, password);
      return [result.uid, result.message];
    } catch (e) {
      return [null, e.toString()];
    }
  }

  /// Signs in a scorekeeper using Firebase Auth.
  /// Then verifies that the UID exists in the 'scorekeepers' collection.
  Future<AuthResult> signInScorekeeper(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        return AuthResult(uid: null, message: "Sign in failed");
      }
      DocumentSnapshot doc =
          await _firestore.collection('scorekeepers').doc(user.uid).get();
      if (!doc.exists) {
        return AuthResult(
            uid: null,
            message:
                "Invalid credentials: account not found in scorekeeper portal");
      }
      return AuthResult(
          uid: user.uid, message: "Scorekeeper sign in successful");
    } on FirebaseAuthException catch (e) {
      return AuthResult(uid: null, message: e.message ?? "Sign in failed");
    } catch (e) {
      return AuthResult(uid: null, message: e.toString());
    }
  }

  /// Signs up a scorekeeper with email and password.
  /// It creates a Scorekeeper instance and saves it under the 'scorekeepers' collection.
  Future<AuthResult> signupScorekeeper({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        return AuthResult(uid: null, message: "Registration failed");
      }
      // Create Scorekeeper instance.
      // Scorekeeper newScorekeeper = Scorekeeper(
      //   id: user.uid,
      //   email: email,
      //   password: password,
      // );
      Map<String, String> newScorekeeper = {
        'email': email,
      };
      await _firestore
          .collection('scorekeepers')
          .doc(user.uid)
          .set(newScorekeeper);
      return AuthResult(
          uid: user.uid, message: "Scorekeeper registration successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return AuthResult(uid: null, message: "The email is already in use");
      }
      return AuthResult(uid: null, message: e.message ?? "Registration failed");
    } catch (e) {
      return AuthResult(uid: null, message: e.toString());
    }
  }

  /// Caller function for registering a scorekeeper.
  /// Returns a List with [uid, message].
  Future<List<String?>> registerScorekeeper({
    required String email,
    required String password,
  }) async {
    try {
      AuthResult result =
          await signupScorekeeper(email: email, password: password);
      return [result.uid, result.message];
    } catch (e) {
      return [null, e.toString()];
    }
  }

  /// Caller function for logging in a scorekeeper.
  /// Returns a List with [uid, message].
  Future<List<String?>> loginScorekeeper(String email, String password) async {
    try {
      AuthResult result = await signInScorekeeper(email, password);
      return [result.uid, result.message];
    } catch (e) {
      return [null, e.toString()];
    }
  }

  // Sign out
  Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();
      return AuthResult(uid: null, message: "Sign out successful");
    } catch (e) {
      return AuthResult(uid: null, message: e.toString());
    }
  }
}
