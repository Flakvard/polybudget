import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polybudget/main.dart';

void main() {
  testWidgets('Current level increments when button is clicked', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TransactionList())); // Build the User widget

    final Transaction transactionConstructor = Transaction(
      text: "Groceries expense",
      total: 184.23,
      category: "Food Category",
      date: "18-10-2023",
      recurring: false,
      transactionType: "Actual",
      bankAccount: "Matkortið",
    );

    final Transaction defaultTransactionValue = Transaction(
        text: "Groceries expense",
        total: 184.23,
        category: "Food Category",
        transactionType: "Actual",
        bankAccount: "Matkortið"
    );

    // DD-MM-YYYY
    DateTime now = DateTime.now();
    String dateToday = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    expect(defaultTransactionValue.text, "Groceries expense");
    expect(defaultTransactionValue.total, 184.23);
    expect(defaultTransactionValue.category, "Food Category");
    expect(transactionConstructor.date, "18-10-2023");
    expect(defaultTransactionValue.date, dateToday);
    expect(defaultTransactionValue.recurring, false);
    expect(defaultTransactionValue.transactionType, "Actual");
    expect(defaultTransactionValue.bankAccount, "Matkortið");

    // expect(find.text('0'), findsOneWidget); // Check that initial value of currentLevel is 0

    // await tester.tap(find.byType(FloatingActionButton)); // Tap the FloatingActionButton
    // await tester.pump(); // Rebuild the widget

    // expect(find.text('1'), findsOneWidget); // Check that currentLevel has incremented to 1
  });
}
