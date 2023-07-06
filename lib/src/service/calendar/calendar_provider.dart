import 'package:Giyin/src/models/wardrobe/combination/combination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
  Combination calendarCombination = Combination();
  FirebaseFirestore? firestore;
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  DateTime? get selectedDay => _selectedDay;
  DateTime get focusedDay => _focusedDay;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    notifyListeners();
  }

  Future<List<String>?> getCombinations() async {
    try {
      final snapshot = await firestore?.collection('combinations').get();
      if (snapshot != null) {
        final combinationNames =
            snapshot.docs.map((doc) => doc.data()['name'] as String).toList();
        return combinationNames;
      } else {
        // Firestore null ise hata yönetimi
        return [];
      }
    } catch (error) {
      // Hata yönetimi
      return [];
    }
  }
}
