import 'package:flutter/material.dart';
import 'package:tehadso/appbar/splash.dart';
import 'package:tehadso/utils/edge_to_edge_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Set global edge-to-edge configuration
    EdgeToEdgeHelper.setEdgeToEdge();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 150, 139, 168),
        ),
        // ✅ Set global app bar theme for edge-to-edge
        appBarTheme: EdgeToEdgeHelper.getAppBarTheme(),
        // ✅ Set global scaffold theme for edge-to-edge
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Photos(),
    );
  }
}
// this is the core code
