import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/remedy_model.dart';

class RemedyFirestoreService {
  final CollectionReference _remedyCollection =
      FirebaseFirestore.instance.collection('remedies');

  // Remedy যুক্ত করুন
  Future<void> addRemedy(RemedyModel remedy) async {
    try {
      await _remedyCollection.doc(remedy.id).set(remedy.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Remedy আপডেট করুন
  Future<void> updateRemedy(RemedyModel remedy) async {
    try {
      await _remedyCollection.doc(remedy.id).update(remedy.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Remedy ডিলিট করুন
  Future<void> deleteRemedy(String id) async {
    try {
      await _remedyCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  // Remedy ফেচ করুন একক ID দ্বারা
  Future<RemedyModel?> getRemedyById(String id) async {
    try {
      DocumentSnapshot doc = await _remedyCollection.doc(id).get();
      if (doc.exists) {
        return RemedyModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Remedy সব ডেটা ফেচ করুন লাইভ স্ট্রিম হিসেবে
  Stream<List<RemedyModel>> getAllRemedies() {
    try {
      return _remedyCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) =>
                RemedyModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  // Remedy সার্চ করুন নাম/keywords দিয়ে
  Future<List<RemedyModel>> searchRemedies(String query) async {
    try {
      QuerySnapshot snapshot = await _remedyCollection
          .where('keywords', arrayContains: query.toLowerCase())
          .get();

      return snapshot.docs
          .map((doc) => RemedyModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
