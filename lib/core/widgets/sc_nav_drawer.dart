import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class SCNavDrawer extends StatelessWidget {
  const SCNavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthenticationBloc>()..add(GetCurrentUserEvent()),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationLoaded) {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 56),
                  ListTile(
                    title: Text(
                      'Screenings',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: GoRouterState.of(context).name ==
                            Routes.screenings
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.screenings);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Reservations',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: GoRouterState.of(context).name ==
                            Routes.userReservations
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.userReservations, params: {
                        'uid': state.authUser.uid
                      });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Purchased tickets',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: GoRouterState.of(context).name ==
                            Routes.userPurchasedTickets
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.userPurchasedTickets, params: {
                        'uid': state.authUser.uid
                      });
                    },
                  ),
                  ListTile(
                    title: Text(
                      'User profile',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: GoRouterState.of(context).name ==
                            Routes.userProfile
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.userProfile, params: {
                        'uid': state.authUser.uid
                      });
                    },
                  ),
                  if (GoRouterState.of(context).name == Routes.userProfile)
                    ListTile(
                      title: Text(
                        'Sign out',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onTap: () {
                        context.pop();
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(SignOutEvent());
                        context.pushReplacementNamed(Routes.signIn);
                      },
                    ),
                ],
              ),
            );
          } else {
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 56),
                  ListTile(
                    title: Text(
                      'Screenings',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: GoRouterState.of(context).name ==
                            Routes.screenings
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.screenings);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Reservations',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.signIn);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Purchased tickets',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.signIn);
                    },
                  ),
                  ListTile(
                    title: Text(
                      'User profile',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      context.pop();
                      context.pushReplacementNamed(Routes.signIn);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
