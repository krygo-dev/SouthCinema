import 'package:flutter/material.dart';
import 'package:south_cinema/features/reservations/domain/entities/purchase.dart';

class TicketsTileState {
  final Purchase purchase;
  bool expanded = false;
  GlobalKey key = GlobalKey();

  TicketsTileState(this.purchase);
}