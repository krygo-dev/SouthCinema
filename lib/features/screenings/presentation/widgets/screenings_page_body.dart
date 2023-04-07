import 'package:flutter/material.dart';
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
  final GlobalKey _key = GlobalKey();
  final ScrollController _controller = ScrollController();
  bool _isPinned = false;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {
    _controller.addListener(
          () {
        final RenderBox renderBox =
        _key.currentContext?.findRenderObject() as RenderBox;

        final Offset offset = renderBox.localToGlobal(Offset.zero);
        final double startY = offset.dy;

        setState(() {
          _isPinned = startY <= 120;
        });
        // print("Check position:  - $startY - $_isStuck");
      },
    );
  }

  void _handleOnSelected(int newValue) {
    setState(() {
      _selected = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                const SCRepertoireDatesRow(),
                const SCRepertoireContainer(),
                Visibility(
                  visible: !_isPinned,
                  maintainAnimation: true,
                  maintainState: true,
                  maintainSize: true,
                  child: SCPlayedAnnouncedRow(
                    key: _key,
                    selected: _selected,
                    onSelected: _handleOnSelected,
                  ),
                ),
                const SCMoviesContainer(),
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
                  selected: _selected,
                  onSelected: _handleOnSelected,
                )),
          ),
      ],
    );
  }
}