import 'package:flutter/material.dart';
import 'package:south_cinema/core/widgets/sc_app_bar.dart';
import 'package:south_cinema/features/screenings/presentation/widgets/sc_repertoire_dates_row.dart';

class ScreeningsPage extends StatelessWidget {
  const ScreeningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SCAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Container(
              height: 44,
              color: Theme.of(context).colorScheme.onBackground,
              child: const SCRepertoireDatesRow(),
            ),
            Padding(
              padding: const EdgeInsets.all(17.0),
              child: Container(
                color: Theme.of(context).colorScheme.onBackground,
                padding: const EdgeInsets.symmetric(vertical: 17),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Creed III',
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '15:00',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '17:30',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '19:00',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '22:00',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Shazam! Fury of the Gods',
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '13:00',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '16:00',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '16:00',
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
