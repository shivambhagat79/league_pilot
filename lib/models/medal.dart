class MedalTally {
  final int gold;
  final int silver;
  final int bronze;

  MedalTally({
    required this.gold,
    required this.silver,
    required this.bronze,
  });

  // Create a MedalTally from a map (e.g., data from Firestore)
  factory MedalTally.fromMap(Map<String, dynamic> map) {
    return MedalTally(
      gold: map['gold'] ?? 0,
      silver: map['silver'] ?? 0,
      bronze: map['bronze'] ?? 0,
    );
  }

  // Convert a MedalTally instance into a map (to store in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'gold': gold,
      'silver': silver,
      'bronze': bronze,
    };
  }
}
