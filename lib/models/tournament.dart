//import 'points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tournament {
  final String name;
  final String hostInstitute;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> admins; // List of admin user IDs (or emails)
  final List<String> sports; // List of sport names or sport IDs
  final List<String> contingents; // List of contingent IDs
  // final List<String> matchIds; // List of match IDs
  // final PointDistribution pointDistribution;
  final int goldMedalPoints ;
  final int silverMedalPoints;
  final int bronzeMedalPoints ;
  final List<String> pictureUrls; // For tournament gallery
  final String status; // Tournament status
  //final GeoPoint hostingInstituteLocation; // Location of the hosting institute
  //final List<GeoPoint> venueCoordinates;  
  final double latitude ;
  final double longitude ;
  final  String security; //security no. of the tournament
  final String medical; //medical no. of the tournament
  final String organiser; //organiser no. of the tournament
  Tournament({
    required this.name,
    required this.hostInstitute,
    required this.startDate,
    required this.endDate,
    required this.admins,
    required this.sports,
    required this.contingents,
    // required this.matchIds,
    //required this.pointDistribution,
    required this.goldMedalPoints,
    required this.silverMedalPoints,
    required this.bronzeMedalPoints,
    required this.pictureUrls,
    required this.status,
   // required this.hostingInstituteLocation,
    //required this.venueCoordinates,
    required this.latitude,
    required this.longitude,
    required this.security,
    required this.medical,
    required this.organiser,
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
      //matchIds: List<String>.from(map['matchIds'] ?? []),
      //pointDistribution: map['pointDistribution'] != null
      //? PointDistribution.fromMap(Map<String, dynamic>.from(map['pointDistribution']))
      //: PointDistribution(winPoints: 0, lossPoints: 0, drawPoints: 0),
      pictureUrls: List<String>.from(map['pictureUrls'] ?? []),
      status: map['status'] ?? '',
      
      goldMedalPoints: map['goldMedalPoints'] ?? 0,
      silverMedalPoints: map['silverMedalPoints'] ?? 0,
      bronzeMedalPoints: map['bronzeMedalPoints'] ?? 0,
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      security: map['security'] ?? '',
      medical: map['medical'] ?? '',
      organiser: map['organiser'] ?? '',
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
      //'matchIds': matchIds,
      //'pointDistribution': pointDistribution.toMap(),
      'pictureUrls': pictureUrls,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'goldMedalPoints': goldMedalPoints,
      'silverMedalPoints': silverMedalPoints, 
      'bronzeMedalPoints': bronzeMedalPoints,
      'security': security,
      'medical': medical,
      'organiser': organiser,
    };
  }
}
