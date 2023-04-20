import 'package:flutter/material.dart';

class SCSeatContainer extends StatelessWidget {
  const SCSeatContainer({
    super.key,
    required this.seatColor,
  });

  final Color seatColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 17,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: seatColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }
}