import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/util/tickets_tile_state.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';
import 'package:south_cinema/features/reservations/presentation/bloc/user_purchased_tickets_bloc.dart';
import 'package:south_cinema/features/reservations/presentation/widgets/sc_tickets_column.dart';
import 'package:south_cinema/injection_container.dart';

class UserPurchasedTicketsPage extends StatelessWidget {
  const UserPurchasedTicketsPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      drawer: const SCNavDrawer(),
      body: BlocProvider(
        create: (_) => sl<UserPurchasedTicketsBloc>()
          ..add(GetUserPurchasedTicketsEvent(uid)),
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: double.infinity),
            padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
            color: Theme.of(context).colorScheme.onBackground,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your tickets',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<UserPurchasedTicketsBloc,
                      UserPurchasedTicketsState>(
                    builder: (context, state) {
                      if (state is UserPurchasedTicketsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UserPurchasedTicketsLoaded) {
                        if (state.purchasedTicketsList.isEmpty) {
                          return const Center(
                            child: Text('You don\'t have any tickets.'),
                          );
                        } else {
                          List<TicketsTileState> tiles = state
                              .purchasedTicketsList
                              .map((purchase) => TicketsTileState(purchase))
                              .toList();

                          return SCTicketsColumn(tilesState: tiles);
                        }
                      } else {
                        return const Center(
                          child: Text('Unexpected error'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
