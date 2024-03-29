import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:south_cinema/core/navigation/navigation_router.dart';
import 'package:south_cinema/core/theme/theme.dart';
import 'package:south_cinema/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:south_cinema/injection_container.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>()..add(GetCurrentUserEvent()),
      child: MaterialApp.router(
        title: 'South Cinema',
        theme: theme(),
        routerConfig: NavigationRouter().router,
      ),
    );
  }
}
