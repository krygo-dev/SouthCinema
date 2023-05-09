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
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationLoggedOut) {
              context.goNamed(Routes.signIn);
            }
          },
          child: Column(
            children: [
              const Text('User profile'),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationLoading) {
                    return Container(
                      width: 107,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme
                            .of(context)
                            .colorScheme
                            .onSurface,
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
      ),
    );
  }
}
