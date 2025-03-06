class Scoreboard {
  final Map<String, int> teamScores;

  Scoreboard({
    required this.teamScores,
  });

  factory Scoreboard.fromMap(Map<String, dynamic> map) {
    return Scoreboard(
      teamScores: Map<String, int>.from(map['teamScores'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teamScores': teamScores,
    };
  }
}
