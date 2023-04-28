import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';

abstract class PurchaseService {
  Future<bool> createNewPurchase(Purchase purchase);
  Future<List<Purchase>> getUserPurchasedTickets(String uid);
}