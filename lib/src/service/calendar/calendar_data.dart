/*
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/calendar/event.dart';

class CalendarData with ChangeNotifier {
  Map<DateTime, List<Event>> events = LinkedHashMap(
    equals: isSameDay,
  );

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  CalendarData() {
    events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
  }

  Future<void> loadFirestoreEvents(DateTime focusedDay) async {
    final firstDay = DateTime(focusedDay.year, focusedDay.month, 1);
    final lastDay = DateTime(focusedDay.year, focusedDay.month + 1, 0);
    events.clear();

    final snap = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .withConverter(
          fromFirestore: Event.fromFirestore,
          toFirestore: (event, options) => event.toFirestore(),
        )
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      events[day] ??= [];
      events[day]!.add(event);
    }
    notifyListeners();
  }
}
*/
