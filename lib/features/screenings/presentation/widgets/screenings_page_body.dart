import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_movies_container.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_played_announced_row.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_repertoire_container.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_repertoire_dates_row.dart';

class ScreeningsPageBody extends StatefulWidget {
  const ScreeningsPageBody({
    super.key,
  });

  @override
  State<ScreeningsPageBody> createState() => _ScreeningsPageBodyState();
}

class _ScreeningsPageBodyState extends State<ScreeningsPageBody> {
  final GlobalKey _playedAnnouncedRowKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool _isPinned = false;
  int _selectedCategory = 0;
  int _selectedDate = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _afterLayout(_) {
    _scrollController.addListener(
      () {
        final RenderBox renderBox = _playedAnnouncedRowKey.currentContext
            ?.findRenderObject() as RenderBox;

        final Offset offset = renderBox.localToGlobal(Offset.zero);
        final double startY = offset.dy;

        setState(() {
          _isPinned = startY <= 120;
        });
      },
    );
  }

  void _handleOnCategorySelected(int newValue) {
    setState(() {
      _selectedCategory = newValue;
    });
    _scrollController.animateTo(
      MediaQuery.of(context).size.height - 200,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  void _handleOnDateSelected(int newValue) {
    setState(() {
      _selectedDate = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationLoaded) {
          final snackBar = SnackBar(
            content: Text('Signed in as ${state.authUser.email}'),
            duration: const Duration(milliseconds: 1500),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
  child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SCRepertoireDatesRow(
                  selected: _selectedDate,
                  onSelected: _handleOnDateSelected,
                ),
                const Padding(
                  padding: EdgeInsets.all(17.0),
                  child: SCRepertoireContainer(),
                ),
                Visibility(
                  visible: !_isPinned,
                  maintainAnimation: true,
                  maintainState: true,
                  maintainSize: true,
                  child: SCPlayedAnnouncedRow(
                    key: _playedAnnouncedRowKey,
                    selected: _selectedCategory,
                    onSelected: _handleOnCategorySelected,
                  ),
                ),
                SCMoviesContainer(reversed: _selectedCategory == 1),
              ],
            ),
          ),
        ),
        if (_isPinned)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Container(
                color: Theme.of(context).colorScheme.background,
                child: SCPlayedAnnouncedRow(
                  selected: _selectedCategory,
                  onSelected: _handleOnCategorySelected,
                )),
          ),
      ],
    ),
);
  }
}
