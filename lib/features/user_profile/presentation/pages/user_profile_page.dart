import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/util/set_text_editing_controller_value.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/core/widgets/sc_nav_drawer.dart';
import 'package:south_cinema/core/widgets/sc_text_button.dart';
import 'package:south_cinema/core/widgets/sc_text_field.dart';
import 'package:south_cinema/features/user_profile/domain/entities/user.dart';
import 'package:south_cinema/features/user_profile/presentation/bloc/user_bloc.dart';
import 'package:south_cinema/injection_container.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();

  bool inputFieldsActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      drawer: const SCNavDrawer(),
      body: BlocProvider(
        create: (_) => sl<UserBloc>()..add(GetUserByIdEvent(widget.uid)),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              final snackBar = SnackBar(
                content: Text(state.message),
                duration: const Duration(milliseconds: 1500),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

            if (state is UserLoaded) {
              setTextEditingControllerValue(
                _contactNumberController,
                state.user.contactNumber,
              );
              setTextEditingControllerValue(
                _streetController,
                state.user.street,
              );
              setTextEditingControllerValue(
                _cityController,
                state.user.city,
              );
              setTextEditingControllerValue(
                _postCodeController,
                state.user.postCode,
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(
                  minHeight: 572,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                color: Theme.of(context).colorScheme.onBackground,
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
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Hello ${state.user.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Check your current profile data below.',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                state.user.email,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                              const SizedBox(height: 10),
                              SCTextField(
                                controller: _contactNumberController,
                                hint: 'contact number',
                                keyboardType: TextInputType.phone,
                                obscure: false,
                                isEnabled: inputFieldsActive,
                              ),
                              SizedBox(height: inputFieldsActive ? 10 : 0),
                              SCTextField(
                                controller: _streetController,
                                hint: 'street',
                                keyboardType: TextInputType.text,
                                obscure: false,
                                isEnabled: inputFieldsActive,
                              ),
                              SizedBox(height: inputFieldsActive ? 10 : 0),
                              SCTextField(
                                controller: _cityController,
                                hint: 'city',
                                keyboardType: TextInputType.text,
                                obscure: false,
                                isEnabled: inputFieldsActive,
                              ),
                              SizedBox(height: inputFieldsActive ? 10 : 0),
                              SCTextField(
                                controller: _postCodeController,
                                hint: 'post code',
                                keyboardType: TextInputType.text,
                                obscure: false,
                                isEnabled: inputFieldsActive,
                              ),
                              const SizedBox(height: 30),
                            ],
                          ),
                          Column(
                            children: [
                              Visibility(
                                visible: inputFieldsActive,
                                child: SCTextButton(
                                  buttonLabel: 'Save',
                                  onPressed: () {
                                    if (inputFieldsActive) {
                                      final user = User(
                                        uid: state.user.uid,
                                        email: state.user.email,
                                        name: state.user.name,
                                        city: _cityController.text,
                                        postCode: _postCodeController.text,
                                        street: _streetController.text,
                                        contactNumber:
                                            _contactNumberController.text,
                                      );

                                      BlocProvider.of<UserBloc>(context).add(
                                        SetOrUpdateUserDataEvent(user),
                                      );

                                      setState(() {
                                        inputFieldsActive = false;
                                      });
                                    }
                                  },
                                ),
                              ),
                              SCTextButton(
                                buttonLabel:
                                    inputFieldsActive ? 'Close' : 'Edit',
                                onPressed: () {
                                  setState(() {
                                    inputFieldsActive = !inputFieldsActive;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
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
          ),
        ),
      ),
    );
  }
}
