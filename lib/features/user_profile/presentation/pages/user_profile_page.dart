import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_text_button.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:south_cinema/features/user_profile/presentation/bloc/user_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<AuthenticationBloc>(),
          ),
          BlocProvider(
            create: (_) => sl<UserBloc>()..add(GetUserByIdEvent(uid)),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationLoggedOut) {
                  context.goNamed(Routes.signIn);
                }

                if (state is AuthenticationError) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                    duration: const Duration(milliseconds: 1500),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserError) {
                  final snackBar = SnackBar(
                    content: Text(state.message),
                    duration: const Duration(milliseconds: 1500),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is UserLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(17),
                  child: Container(
                    width: double.infinity,
                    height: 572,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 23, vertical: 12),
                    color: Theme.of(context).colorScheme.onBackground,
                    child: Column(
                      children: [
                        Text(state.user.email),
                        Text(state.user.name),
                        Text(state.user.uid),
                        Text(state.user.contactNumber),
                        Text(state.user.street),
                        Text(state.user.city),
                        Text(state.user.postCode),
                        BlocBuilder<AuthenticationBloc, AuthenticationState>(
                          builder: (context, state) {
                            if (state is AuthenticationLoading) {
                              return Container(
                                width: 107,
                                height: 34,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                child: Center(
                                  child: Transform.scale(
                                    scale: 0.5,
                                    child: const CircularProgressIndicator(),
                                  ),
                                ),
                              );
                            } else {
                              return SCTextButton(
                                buttonLabel: 'Sign out',
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(SignOutEvent());
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text('Unexpected error occurred'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
