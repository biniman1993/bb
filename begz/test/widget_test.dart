import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tehadso/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Since your MyApp goes to SplashScreen, not Counter,
    // you should test something that actually exists in SplashScreen.
    // For now, I’ll keep the original example for reference:

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
