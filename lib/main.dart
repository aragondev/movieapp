import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie App',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
        hintColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          color: Colors.deepPurple,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontFamily: 'Cinzel',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.yellowAccent,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cinzel',
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: Colors.white70,
          ),
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
