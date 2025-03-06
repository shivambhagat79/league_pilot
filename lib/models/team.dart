class Team {
  final String name;
  final String
      contingentName; // Alternatively, you could store an ID reference.
  final String sport;
  final List<String>
      players; // List of player IDs which will be genreated by firestore in future
  final String gender; // For example, "male" or "female".
  final int noOfPlayers; // Total number of players
  final String captain; // Player ID of the team captain.

  Team({
    required this.name,
    required this.contingentName,
    required this.sport,
    required this.players,
    required this.gender,
    required this.noOfPlayers,
    required this.captain,
  });

  // Factory constructor to create a Team instance from a map (e.g., from Firestore)
  factory Team.fromMap(Map<String, dynamic> map) {
    List<String> playersList = [];
    if (map['players'] != null) {
      // Ensures that the players field is a list of strings.
      playersList = List<String>.from(map['players']);
    }
    return Team(
      name: map['name'] ?? '',
      contingentName: map['contingentName'] ?? '',
      sport: map['sport'] ?? '',
      players: playersList,
      gender: map['gender'] ?? '',
      noOfPlayers: map['noOfPlayers'] ?? 0,
      captain: map['captain'] ?? '',
    );
  }

  // Converts a Team instance into a map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'contingentName': contingentName,
      'sport': sport,
      'players': players,
      'gender': gender,
      'noOfPlayers': noOfPlayers,
      'captain': captain,
    };
  }
}
