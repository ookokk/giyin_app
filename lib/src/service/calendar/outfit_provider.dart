import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/outfit/outfit.dart';

class OutfitProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference<Map<String, dynamic>> _outfitsCollection =
      FirebaseFirestore.instance.collection('outfits');

  List<Outfit> _outfits = [];

  List<Outfit> get outfits => _outfits;

  Future<void> fetchOutfits() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _outfitsCollection.get();

      _outfits = snapshot.docs.map((doc) {
        final outfitImages = List<String>.from(doc['outfitImages']);
        return Outfit(outfitImages);
      }).toList();

      notifyListeners();
    } catch (error) {
      print('Error fetching outfits: $error');
    }
  }

  Future<void> addOutfit(Outfit outfit) async {
    try {
      final outfitData = {
        'outfitImages': outfit.outfitImages,
      };

      final DocumentReference<Map<String, dynamic>> docRef =
          await _outfitsCollection.add(outfitData);

      final newOutfit = Outfit(outfit.outfitImages);
      _outfits.add(newOutfit);

      notifyListeners();
      print('Outfit added: $newOutfit');
    } catch (error) {
      print('Error adding outfit: $error');
    }
  }

  Future<void> removeOutfit(Outfit outfit) async {
    try {
      final outfitIndex = _outfits.indexOf(outfit);

      if (outfitIndex >= 0) {
        await _outfitsCollection.doc(outfitIndex.toString()).delete();
        _outfits.removeAt(outfitIndex);

        notifyListeners();
        print('Outfit removed: $outfit');
      }
    } catch (error) {
      print('Error removing outfit: $error');
    }
  }
}

class ExampleOutfitProvider extends OutfitProvider {
  ExampleOutfitProvider() {
    // Örnek bir kombin oluşturmak için OutfitProvider'ı kullanabilirsiniz
    final outfit = Outfit([
      'assets/images/outfit1.jpg', // Kendi asset yolunuzu kullanın
      'assets/images/outfit2.jpg',
    ]);

    addOutfit(outfit);
  }
}
