import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:skypersky/main.dart';

void main() {
  testWidgets('Protection toggle switches on and off', (
    tester,
  ) async {
    await tester.pumpWidget(const SkyperkyApp());

    // Verify initial state: protection is off.
    expect(find.text('Protection'), findsOneWidget);
    expect(find.text('Skypersky'), findsOneWidget);
    expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
    expect(find.byIcon(Icons.verified_user), findsNothing);

    // Tap the switch to enable protection.
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    // Verify protection is now on.
    expect(find.byIcon(Icons.verified_user), findsOneWidget);
    expect(find.byIcon(Icons.shield_outlined), findsNothing);

    // Tap again to disable.
    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    // Verify protection is off again.
    expect(find.byIcon(Icons.shield_outlined), findsOneWidget);
    expect(find.byIcon(Icons.verified_user), findsNothing);
  });
}
