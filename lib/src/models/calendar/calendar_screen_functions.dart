import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'event.dart';

class CalendarFunctions {
  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  static Future<Map<DateTime, List<Event>>> loadFirestoreEvents(
      DateTime focusedDay) async {
    final firstDay = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDay = DateTime(focusedDay.year, focusedDay.month + 1, 0);
    final events = LinkedHashMap<DateTime, List<Event>>();

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (events[day] == null) {
        events[day] = [];
      }
      events[day]!.add(event);
    }
    return events;
  }
}
