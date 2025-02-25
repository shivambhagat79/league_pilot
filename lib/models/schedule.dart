import 'package:cloud_firestore/cloud_firestore.dart';

class Schedule {
  final DateTime date;
  final String time;
  final String venue;

  Schedule({
    required this.date,
    required this.time,
    required this.venue,
  });

  // Creates a Schedule instance from a map (e.g., from Firestore)
  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      date: map['date'] is Timestamp 
          ? (map['date'] as Timestamp).toDate() 
          : DateTime.tryParse(map['date'] ?? '') ?? DateTime.now(),
      time: map['time'] ?? '',
      venue: map['venue'] ?? '',
    );
  }

  // Converts a Schedule instance into a map (for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'date': date, // Firestore will store this as a timestamp
      'time': time,
      'venue': venue,
    };
  }
}
