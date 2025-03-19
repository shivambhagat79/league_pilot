import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Schedule {
  final DateTime date;
  final TimeOfDay starttime;
  final TimeOfDay endtime;
  final String venue;

  Schedule({
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.venue,
  });

  /// Converts a Schedule instance into a map (for saving to Firestore).
  /// - `date` will be stored as a Firestore `Timestamp`.
  /// - `starttime` and `endtime` are stored as maps with `hour` and `minute`.
  Map<String, dynamic> toMap() {
    return {
      'date': date, // Firestore automatically converts DateTime -> Timestamp
      'starttime': {
        'hour': starttime.hour,
        'minute': starttime.minute,
      },
      'endtime': {
        'hour': endtime.hour,
        'minute': endtime.minute,
      },
      'venue': venue,
    };
  }

  /// Creates a Schedule instance from a map (e.g., from Firestore).
  /// Expects:
  /// - `date` to be a Firestore Timestamp or a string that can be parsed.
  /// - `starttime` and `endtime` to be maps with `hour` and `minute`.
  /// - `venue` to be a string.
  factory Schedule.fromMap(Map<String, dynamic> map) {
    // Handle date, which may be a Timestamp or a string.
    DateTime parsedDate;
    if (map['date'] is Timestamp) {
      parsedDate = (map['date'] as Timestamp).toDate();
    } else {
      // Fallback if stored as a string, or if null
      parsedDate = DateTime.tryParse(map['date'] ?? '') ?? DateTime.now();
    }

    // Parse starttime and endtime. Fallback to 00:00 if not present.
    final start = map['starttime'] ?? {};
    final end = map['endtime'] ?? {};

    return Schedule(
      date: parsedDate,
      starttime: TimeOfDay(
        hour: start['hour'] ?? 0,
        minute: start['minute'] ?? 0,
      ),
      endtime: TimeOfDay(
        hour: end['hour'] ?? 0,
        minute: end['minute'] ?? 0,
      ),
      venue: map['venue'] ?? '',
    );
  }
}
