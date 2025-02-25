import 'medal.dart';

class TournamentContingent {
  final String id; // Unique identifier for the contingent
  final String name;
  final String leader;
  final MedalTally medalTally;

  TournamentContingent({
    required this.id,
    required this.name,
    required this.leader,
    required this.medalTally,
  });

  // Create a TournamentContingent from a map (e.g., data from Firestore)
  // The document ID is passed as the 'id' parameter.
  factory TournamentContingent.fromMap(String id, Map<String, dynamic> map) {
    return TournamentContingent(
      id: id,
      name: map['name'] ?? '',
      leader: map['leader'] ?? '',
      medalTally: map.containsKey('medalTally')
          ? MedalTally.fromMap(Map<String, dynamic>.from(map['medalTally']))
          : MedalTally(gold: 0, silver: 0, bronze: 0),
    );
  }

  // When saving to Firestore, you might not need to include the id field
  // because it can be the document id, but you can include it if desired.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'leader': leader,
      'medalTally': medalTally.toMap(),
      'id': id,
    };
  }
}
