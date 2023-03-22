import 'package:flutter/material.dart';

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
        centerTitle: true,
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: const Center(child: Icon(Icons.people)),
    );
  }
}
