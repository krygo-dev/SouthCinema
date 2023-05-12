import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';
import 'package:south_cinema/core/widgets/sc_text_button.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SCAppBar(),
        drawer: const SCNavDrawer(),
        body: BlocProvider(
          create: (_) => sl<AuthenticationBloc>()..add(GetCurrentUserEvent()),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationError) {
                final snackBar = SnackBar(
                  content: Text(state.message),
                  duration: const Duration(milliseconds: 1500),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              if (state is AuthenticationLoaded) {
                context.pushNamed(
                  Routes.userProfile,
                  params: {
                    'uid': state.authUser.uid,
                  },
                );
              }
            },
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
                        'Sign in to your account',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'email',
                          hintStyle: Theme.of(context).textTheme.labelLarge,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        showCursor: true,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'password',
                          hintStyle: Theme.of(context).textTheme.labelLarge,
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        showCursor: true,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
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
                              buttonLabel: 'Sign in',
                              onPressed: () {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(
                                  SignInWithEmailAndPasswordEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
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
                          const Text('Don\'t have an account? '),
                          GestureDetector(
                            onTap: () {
                              context.goNamed(Routes.signUp);
                            },
                            child: Text(
                              'Create one here',
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
