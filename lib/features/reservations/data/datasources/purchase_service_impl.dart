import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:south_cinema/core/error/error.dart';
import 'package:south_cinema/features/reservations/data/datasources/purchase_service.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';

class PurchaseServiceImpl implements PurchaseService {
  final FirebaseFirestore firebaseFirestore;

  PurchaseServiceImpl(this.firebaseFirestore);

  @override
  Future<bool> createNewPurchase(Purchase purchase) async {
    try {
      final collectionRef = firebaseFirestore.collection('purchases');
      final documentId = await collectionRef.add(purchase.toJson()).then((doc) => doc.id);

      await collectionRef.doc(documentId).update({'id': documentId});

      return true;
    } on FirebaseException catch (e) {
      throw SettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

  @override
  Future<List<Purchase>> getUserPurchasedTickets(String uid) async {
    try {
      final snapshots = (await firebaseFirestore
          .collection('purchases')
          .where('userId', isEqualTo: uid)
          .get()).docs;

      final purchasedTicketsList = snapshots
          .map((snapshot) => Purchase.fromJson(snapshot.data()))
          .toList();
      return purchasedTicketsList;
    } on FirebaseException catch (e) {
      throw GettingDataError(message: e.message ?? 'Unexpected error');
    }
  }

}