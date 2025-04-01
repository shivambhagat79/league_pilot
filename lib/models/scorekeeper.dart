class Scorekeeper {
  final String id; // Firestore document ID
  final String email;
  final String password; // Ideally, avoid storing plain text passwords

  Scorekeeper({
    required this.id,
    required this.email,
    required this.password,
  });

  // Creates a Scorekeeper instance from a map (for example, from Firestore)
  factory Scorekeeper.fromMap(String id, Map<String, dynamic> map) {
    return Scorekeeper(
      id: id,
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  // Converts a Scorekeeper instance into a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }
}
