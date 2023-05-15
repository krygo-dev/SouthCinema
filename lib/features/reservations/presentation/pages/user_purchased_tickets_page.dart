import 'package:flutter/material.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';

class UserPurchasedTicketsPage extends StatelessWidget {
  const UserPurchasedTicketsPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      drawer: const SCNavDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Container(
          width: double.infinity,
          height: 572,
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
          color: Theme.of(context).colorScheme.onBackground,
          child: Column(
            children: const [
              Text('Purchased tickets'),
            ],
          ),
        ),
      ),
    );
  }
}
