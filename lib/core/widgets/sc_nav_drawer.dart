import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';

class SCNavDrawer extends StatelessWidget {
  const SCNavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 32),
          ListTile(
            title: Text(
              'Screenings',
              style: TextStyle(
                color: GoRouterState.of(context).name == Routes.screenings
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              context.pushNamed(Routes.screenings);
            },
          ),
          ListTile(
            title: Text(
              'User profile',
              style: TextStyle(
                color: GoRouterState.of(context).name == Routes.userProfile
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
            onTap: () {
              context.pushNamed(Routes.userProfile, params: {
                'uid': (BlocProvider.of<AuthenticationBloc>(context).state
                        as AuthenticationLoaded)
                    .authUser
                    .uid,
              });
            },
          ),
          if (GoRouterState.of(context).name == Routes.userProfile)
            ListTile(
              title: Text(
                'Sign out',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onTap: () {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(SignOutEvent());
              },
            ),
        ],
      ),
    );
  }
}
