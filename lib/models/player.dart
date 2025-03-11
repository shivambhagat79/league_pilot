class Player {
  final String id; //  (Firestore document ID)
  final String name;
  final String email;
  final String phoneNumber;
  final String tournamentContingent;
  final String tournament;

  Player({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.tournamentContingent,
    required this.tournament,
  });

  // Creates a Player instance from a map (e.g., from Firebase)
  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      tournamentContingent: map['tournamentContingent'] ?? '',
      tournament: map['tournament'] ?? '',
    );
  }

  // Converts a Player instance into a map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'tournamentContingent': tournamentContingent,
      'tournament': tournament,
    };
  }
}
