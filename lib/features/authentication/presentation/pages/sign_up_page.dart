import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';
import 'package:south_cinema/core/widgets/sc_text_button.dart';
import 'package:south_cinema/core/widgets/sc_text_field.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/presentation/bloc/user_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SCAppBar(),
        drawer: const SCNavDrawer(),
        body: BlocProvider(
          create: (_) => sl<UserBloc>(),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationError) {
                    final snackBar = SnackBar(
                      content: Text(state.message),
                      duration: const Duration(milliseconds: 1500),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (state is AuthenticationLoaded) {
                    final User user = User(
                      uid: state.authUser.uid,
                      email: state.authUser.email ?? '',
                      name: state.authUser.displayName ?? '',
                      city: '',
                      postCode: '',
                      street: '',
                      contactNumber: '',
                    );

                    BlocProvider.of<UserBloc>(context)
                        .add(SetOrUpdateUserDataEvent(user));
                  }
                },
              ),
              BlocListener<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is UserLoaded) {
                    context.pushNamed(
                      Routes.userProfile,
                      params: {
                        'uid': state.user.uid,
                      },
                    );
                  }

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: 572,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 12),
                  color: Theme.of(context).colorScheme.onBackground,
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        'Create new account',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      SCTextField(
                          controller: _emailController,
                          hint: 'email',
                          keyboardType: TextInputType.emailAddress,
                          obscure: false,
                          isEnabled: true,
                      ),
                      const SizedBox(height: 16),
                      SCTextField(
                        controller: _passwordController,
                        hint: 'password',
                        keyboardType: TextInputType.text,
                        obscure: true,
                        isEnabled: true,
                      ),
                      const SizedBox(height: 16),
                      SCTextField(
                        controller: _repeatPasswordController,
                        hint: 'repeat password',
                        keyboardType: TextInputType.text,
                        obscure: true,
                        isEnabled: true,
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          if (state is AuthenticationLoading) {
                            return Container(
                              width: 107,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.onSurface,
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
                              buttonLabel: 'Sign up',
                              onPressed: () {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(
                                  SignUpWithEmailAndPasswordEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    repeatPassword:
                                        _repeatPasswordController.text,
                                  ),
                                );
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () {
                              context.goNamed(Routes.signIn);
                            },
                            child: Text(
                              'Sign in here',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
