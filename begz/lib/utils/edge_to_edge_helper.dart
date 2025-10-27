import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Utility class to ensure consistent edge-to-edge display across all screens
class EdgeToEdgeHelper {
  /// Sets up edge-to-edge display for any screen
  static void setEdgeToEdge() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light, // For iOS
    ));
  }

  /// Creates a consistent AppBar theme for edge-to-edge
  static AppBarTheme getAppBarTheme() {
    return const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  /// Creates a consistent Scaffold for edge-to-edge
  static Widget createEdgeToEdgeScaffold({
    required Widget body,
    PreferredSizeWidget? appBar,
    Widget? drawer,
    Widget? endDrawer,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    Widget? bottomNavigationBar,
    Widget? bottomSheet,
    Color? backgroundColor,
    bool extendBody = false,
    bool extendBodyBehindAppBar = true,
  }) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
      backgroundColor: backgroundColor,
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      body: SafeArea(
        child: body,
      ),
    );
  }

}

/// Mixin for StatefulWidgets to automatically handle edge-to-edge
mixin EdgeToEdgeMixin<T extends StatefulWidget> on State<T> implements WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    EdgeToEdgeHelper.setEdgeToEdge();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      EdgeToEdgeHelper.setEdgeToEdge();
    }
  }
}
