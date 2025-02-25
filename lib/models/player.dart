class Player {
  final String name;
  final String email;
  final String phoneNumber;
  final String tournamentContingent;

  Player({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.tournamentContingent,
  });

  // Creates a Player instance from a map (e.g., from Firebase)
  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      tournamentContingent: map['tournamentContingent'] ?? '',
    );
  }

  // Converts a Player instance into a map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'tournamentContingent': tournamentContingent,
    };
  }
}
