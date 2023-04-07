import 'dart:async';

import 'package:flutter/material.dart';
import 'package:south_cinema/features/screenings/presentation/pages/screenings_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Redirection from splash page to home
    /// TEMPORARY SOLUTION
    Timer(
      const Duration(seconds: 3),
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScreeningsPage()),
          ),
    );

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
