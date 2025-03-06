class PointDistribution {
  final int winPoints;
  final int lossPoints;
  final int drawPoints;

  PointDistribution({
    required this.winPoints,
    required this.lossPoints,
    required this.drawPoints,
  });

  factory PointDistribution.fromMap(Map<String, dynamic> map) {
    return PointDistribution(
      winPoints: map['winPoints'] ?? 0,
      lossPoints: map['lossPoints'] ?? 0,
      drawPoints: map['drawPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'winPoints': winPoints,
      'lossPoints': lossPoints,
      'drawPoints': drawPoints,
    };
  }
}
