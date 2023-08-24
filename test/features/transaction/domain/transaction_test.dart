import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart';

void main() {
  testWidgets('Transaction class construction test', (WidgetTester tester) async {
    // testing constructor
    final Transaction transactionConstructor = Transaction(
      id: "1",
      text: "Groceries expense",
      amount: 184.23,
      category: Category(id: "1",name: "Food Category"),
      date: DateTime.parse("2023-10-18"),
      recurring: false,
      transactionType: TransactionType.expected,
      bankAccount: BankAccount(id: "1",name: "Matkortið"),
      budget: Budget(id: "1", name: "Personal Budget"),
    );

    // testing default constructor
    final Transaction defaultTransactionValue = Transaction(
        id: "1",
        text: "Groceries expense",
        amount: 184.23,
        category: Category(id: "1",name: "Food Category"),
        transactionType: TransactionType.actual,
        bankAccount: BankAccount(id: "1",name: "Matkortið"),
        budget: Budget(id: "1", name: "Personal Budget"),
    );

    // DD-MM-YYYY
    DateTime now = DateTime.now();
    String dateToday = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";

    expect(defaultTransactionValue.text, "Groceries expense");
    expect(defaultTransactionValue.amount, 184.23);
    expect(defaultTransactionValue.category.name, "Food Category");
    expect(transactionConstructor.getFormatDate(), "18-10-2023");
    expect(defaultTransactionValue.getFormatDate(), dateToday);
    // expect(defaultTransactionValue.date, DateTime.now()); // cannot test because of milliseconds
    expect(defaultTransactionValue.getFormatDate(), dateToday);
    expect(defaultTransactionValue.recurring, false);
    expect(transactionConstructor.recurring, false);
    expect(defaultTransactionValue.transactionType.name, "actual");
    expect(transactionConstructor.transactionType.name, "expected");
    expect(defaultTransactionValue.bankAccount.name, "Matkortið");
    expect(defaultTransactionValue.budget.name, "Personal Budget");

    // expect(find.text('0'), findsOneWidget); // Check that initial value of currentLevel is 0

    // await tester.tap(find.byType(FloatingActionButton)); // Tap the FloatingActionButton
    // await tester.pump(); // Rebuild the widget

    // expect(find.text('1'), findsOneWidget); // Check that currentLevel has incremented to 1
  });

  testWidgets('Current level increments when button is clicked', (WidgetTester tester) async {
    //await tester.pumpWidget(const MaterialApp(home: TransactionList())); // Build the User widget
  });

}
