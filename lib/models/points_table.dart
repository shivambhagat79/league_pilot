import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a single points table (e.g., "general" or "sport_football").
/// 'standings' is a map of contingent -> map of stats.
class PointsTable {
  final String id; // Firestore doc ID, e.g. "general", "sport_football"
  final Map<String, dynamic> standings;

  PointsTable({
    required this.id,
    required this.standings,
  });

  // Convert Firestore data into a PointsTable object
  factory PointsTable.fromMap(String id, Map<String, dynamic> map) {
    return PointsTable(
      id: id,
      standings: map['standings'] ?? {},
    );
  }

  // Convert a PointsTable object to a map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'standings': standings,
    };
  }
}
