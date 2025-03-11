class Admin {
  final String id;
  final String name;
  final String email;
  final String password; // Consider not storing plain text passwords
  final String tournament;
  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.tournament,
  });

  // Creates an Admin instance from a Firestore map.
  // The 'id' can be set using the document ID from Firestore.
  factory Admin.fromMap( Map<String, dynamic> map) {
    return Admin(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      tournament: map['tournament'] ?? '',
    );
  }

  // Converts an Admin instance to a map for saving to Firestore.
  // Typically, you wouldn't store the password here if using Firebase Auth.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'tournament': tournament,
    };
  }
}
