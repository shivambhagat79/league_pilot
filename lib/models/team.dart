class Team {
  final String tournamentName;
  final String contingentName;
  final String sport;
  final String gender;
  final String captainName;
  final String captainEmail;
  final List<Map<String, String>> players; // Each element: { 'email': ..., 'name': ... }

  Team({
    required this.tournamentName,
    required this.contingentName,
    required this.sport,
    required this.gender,
    required this.captainName,
    required this.captainEmail,
    required this.players,
  });

  // Factory constructor to create a Team instance from a map.
  // It converts the 'players' field into a List<Map<String, String>>.
  factory Team.fromMap(Map<String, dynamic> map) {
    // Here we make sure that the players list is properly parsed.
    // We expect map['players'] to be a List of dynamic objects that can be cast to Map<String, String>.
    List<Map<String, String>> playersList = [];
    if (map['players'] != null) {
      // We need to iterate over each item and cast it.
      for (var item in map['players']) {
        // Ensure that each item is a Map and convert it accordingly.
        // If the item isn't already a Map<String, String>, we'll try to convert its keys and values.
        if (item is Map) {
          // Optionally, you could add further type validation here.
          playersList.add(Map<String, String>.from(item));
        }
      }
    }

    return Team(
      tournamentName: map['tournamentName'] ?? '',
      contingentName: map['contingentName'] ?? '',
      sport: map['sport'] ?? '',
      gender: map['gender'] ?? '',
      captainName: map['captainName'] ?? '',
      captainEmail: map['captainEmail'] ?? '',
      players: playersList,
    );
  }

  // Converts this Team object into a map for saving to Firestore.
  Map<String, dynamic> toMap() {
    return {
      'tournamentName': tournamentName,
      'contingentName': contingentName,
      'sport': sport,
      'gender': gender,
      'captainName': captainName,
      'captainEmail': captainEmail,
      'players': players, // This will be stored as a list of maps.
    };
  }
}
