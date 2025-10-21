import 'package:flutter/material.dart';
import 'package:tehadso/appbar/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 150, 139, 168),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
// this is the core code
