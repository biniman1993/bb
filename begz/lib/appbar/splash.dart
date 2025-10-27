import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tehadso/home2.dart'; // Photos onboarding
import 'package:tehadso/listoftitile/listoftimhirt.dart'; // Main screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload splash image for smooth display
    precacheImage(const AssetImage('assets/splash.jpg'), context);
  }

  @override
  void initState() {
    super.initState();

    // ✅ Immediately set full-screen with white icons
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      systemNavigationBarColor: Colors.transparent, // Transparent nav bar
      statusBarIconBrightness: Brightness.light, // White icons
      systemNavigationBarIconBrightness: Brightness.light, // White nav icons
      statusBarBrightness: Brightness.dark, // For iOS
    ));

    // Start navigation after delay
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final lastPage = prefs.getInt('last_opened_page');

    if (!mounted) return;

    if (hasSeenOnboarding && lastPage != null) {
      _navigateTo(ScrollableListView(lastPage: lastPage));
    } else if (hasSeenOnboarding) {
      _navigateTo(const ScrollableListView());
    } else {
      _navigateTo(const Photos());
    }
  }

  void _navigateTo(Widget page) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => page,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );

    // ✅ Restore normal system UI after leaving splash
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Make sure the splash image covers the full screen
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/splash.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
