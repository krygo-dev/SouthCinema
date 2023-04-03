import 'package:flutter/material.dart';
import 'package:south_cinema/core/theme/colors.dart';

class ScreeningsPage extends StatelessWidget {
  const ScreeningsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage('assets/images/logo_230x76.png'),
          width: 230,
          height: 76,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          children: [
            Container(
              height: 44,
              color: Theme.of(context).colorScheme.onBackground,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today_outlined),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '01/01/2023',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                          shadows: [
                            const Shadow(
                              color: secondaryColor,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'SUNDAY',
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          shadows: [
                            const Shadow(
                              color: primaryColor,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '02/01/2023',
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text('MONDAY',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '03/01/2023',
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text('TUESDAY',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '04/01/2023',
                        style: Theme.of(context).textTheme.labelMedium!,
                      ),
                      Text('WEDNESDAY',
                          style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                ],
              ),
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
                                  color: Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '15:00',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color: Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '17:30',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color: Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '19:00',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color: Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '22:00',
                                    style: Theme.of(context).textTheme.labelMedium,
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
                                  color: Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '13:00',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color: Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '16:00',
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 41,
                                  height: 24,
                                  color: Theme.of(context).colorScheme.background,
                                  alignment: Alignment.center,
                                  child: Text(
                                    '16:00',
                                    style: Theme.of(context).textTheme.labelMedium,
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
