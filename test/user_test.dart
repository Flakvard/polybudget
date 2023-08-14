import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polybudget/user.dart';

void main() {
  testWidgets('Current level increments when button is clicked', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: User())); // Build the User widget

    expect(find.text('0'), findsOneWidget); // Check that initial value of currentLevel is 0

    await tester.tap(find.byType(FloatingActionButton)); // Tap the FloatingActionButton
    await tester.pump(); // Rebuild the widget

    expect(find.text('1'), findsOneWidget); // Check that currentLevel has incremented to 1
  });
}
