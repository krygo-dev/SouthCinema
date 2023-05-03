import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// Redirect to ScreeningsPage (main application page) after 3 seconds ///
    Timer(const Duration(seconds: 3), () => context.goNamed(Routes.screenings));

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Image(
              image: AssetImage('assets/images/logo_350x350.png'),
              width: 350,
              height: 350,
            ),
          )
        ],
      ),
    );
  }
}
