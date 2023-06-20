import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
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

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    firestore = FirebaseFirestore.instance;
  }

  CalendarProvider() {
    initializeFirebase();
  }

  // Kullanıcının kombinasyonunu Firestore'a eklemek için bir fonksiyon
  Future<void> addCombination(String combinationName) async {
    try {
      await firestore
          ?.collection('combinations')
          .add({'name': combinationName});
      notifyListeners();
    } catch (error) {
      // Hata yönetimi
    }
  }

  // Kullanıcının kombinasyonlarını Firestore'dan almak için bir fonksiyon
  Future<List<String>?> getCombinations() async {
    try {
      final snapshot = await firestore?.collection('combinations').get();
      final combinationNames =
          snapshot?.docs.map((doc) => doc.data()['name'] as String).toList();
      return combinationNames;
    } catch (error) {
      // Hata yönetimi
      return [];
    }
  }
}
