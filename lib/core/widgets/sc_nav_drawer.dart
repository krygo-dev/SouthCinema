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
          const SizedBox(height: 56),
          ListTile(
            title: Text(
              'Screenings',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: GoRouterState.of(context).name == Routes.screenings
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            onTap: () {
              context.pushNamed(Routes.screenings);
            },
          ),
          ListTile(
            title: Text(
              'User profile',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: GoRouterState.of(context).name == Routes.userProfile
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              try {
                context.pushNamed(Routes.userProfile, params: {
                  'uid': (BlocProvider.of<AuthenticationBloc>(context).state
                          as AuthenticationLoaded)
                      .authUser
                      .uid,
                });
              } on TypeError {
                context.pushNamed(Routes.signIn);
              }
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
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(SignOutEvent());
              },
            ),
        ],
      ),
    );
  }
}
