import 'points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tournament {
  final String name;
  final String hostInstitute;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> admins; // List of admin user IDs (or emails)
  final List<String> sports; // List of sport names or sport IDs
  final List<String> contingents; // List of contingent IDs
  final PointDistribution pointDistribution;

  Tournament({
    required this.name,
    required this.hostInstitute,
    required this.startDate,
    required this.endDate,
    required this.admins,
    required this.sports,
    required this.contingents,
    required this.pointDistribution,
  });

  // Creates a Tournament instance from a map (e.g., from Firestore)
  factory Tournament.fromMap(Map<String, dynamic> map) {
    return Tournament(
      name: map['name'] ?? '',
      hostInstitute: map['hostInstitute'] ?? '',
      startDate: map['startDate'] is Timestamp
          ? (map['startDate'] as Timestamp).toDate()
          : DateTime.tryParse(map['startDate'] ?? '') ?? DateTime.now(),
      endDate: map['endDate'] is Timestamp
          ? (map['endDate'] as Timestamp).toDate()
          : DateTime.tryParse(map['endDate'] ?? '') ?? DateTime.now(),
      admins: List<String>.from(map['admins'] ?? []),
      sports: List<String>.from(map['sports'] ?? []),
      contingents: List<String>.from(map['contingents'] ?? []),
      pointDistribution: map['pointDistribution'] != null
          ? PointDistribution.fromMap(
              Map<String, dynamic>.from(map['pointDistribution']))
          : PointDistribution(winPoints: 0, lossPoints: 0, drawPoints: 0),
    );
  }

  // Converts a Tournament instance into a map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'hostInstitute': hostInstitute,
      'startDate': startDate,
      'endDate': endDate,
      'admins': admins,
      'sports': sports,
      'contingents': contingents,
      'pointDistribution': pointDistribution.toMap(),
    };
  }
}
