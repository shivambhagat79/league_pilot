class CricketScoreboard {
  /// A map where keys are team names and values are a map with their statistics.
  /// Expected structure for each team:
  /// {
  ///   "runs": int,
  ///   "wickets": int,
  ///   "overs": double
  /// }
  final Map<String, Map<String, dynamic>> teamStats;

  CricketScoreboard({required this.teamStats});

  /// Creates a CricketScoreboard instance from a Firestore map.
  factory CricketScoreboard.fromMap(Map<String, dynamic> map) {
    Map<String, Map<String, dynamic>> teamStats = {};
    map.forEach((key, value) {
      if (value is Map) {
        teamStats[key] = Map<String, dynamic>.from(value);
      }
    });
    return CricketScoreboard(teamStats: teamStats);
  }

  /// Converts this CricketScoreboard instance to a map for saving.
  Map<String, dynamic> toMap() {
    return teamStats;
  }
}
