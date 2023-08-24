import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:polybudget/features/transaction/presentation/TransactionCardContent.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart';

void main() {
  testWidgets('Transaction content displays correctly', (WidgetTester tester) async {
    final List<Transaction> transactions = [
      Transaction(id: "1", budget: Budget(name: "Personal budget", id: "1"), text: "Groceries expense",amount: 184.23,category: Category(id: "1", name: "Food Category"),date: DateTime.parse("2023-10-18"), transactionType: TransactionType.expected,recurring: false,bankAccount: BankAccount(id: "1",name: "Matkortið")),
      Transaction(id: "2", budget: Budget(name: "Personal budget", id: "2"), text: "MovieNight expense",amount: 14,category: Category(id: "2", name: "Privat Category"),transactionType: TransactionType.expected,bankAccount: BankAccount(id: "1",name: "Matkortið")),
      Transaction(id: "3", budget: Budget(name: "Personal budget", id: "3"), text: "Hotel expense",amount: 84.3,category: Category(id: "3", name: "Vacation Category"),date: DateTime.parse("2023-10-18"), transactionType: TransactionType.actual,recurring: false,bankAccount: BankAccount(id: "1",name: "Matkortið")),
      Transaction(id: "4", budget: Budget(name: "Personal budget", id: "4"), text: "Spotify expense",amount: 99,category: Category(id: "4", name: "Privat Category"),transactionType: TransactionType.actual, date: DateTime.parse("2023-10-28"), recurring: true, bankAccount: BankAccount(id: "1",name: "Matkortið")),
    ];

    // DD-MM-YYYY
    DateTime now = DateTime.now();
    String dateToday = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";


    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transaction: transactions[0],)));
    expect(find.text('Groceries expense'), findsOneWidget);
    expect(find.text('184.23'), findsOneWidget);
    expect(find.text('Food Category'), findsOneWidget);
    expect(find.text('18-10-2023'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transaction: transactions[1])));
    expect(find.text('MovieNight expense'), findsOneWidget);
    expect(find.text('14.0'), findsOneWidget);
    expect(find.text('Privat Category'), findsOneWidget);
    expect(find.text(dateToday), findsOneWidget); // today
    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transaction: transactions[2])));
    expect(find.text('Hotel expense'), findsOneWidget);
    expect(find.text('84.3'), findsOneWidget);
    expect(find.text('Vacation Category'), findsOneWidget);
    expect(find.text('18-10-2023'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transaction: transactions[3])));
    expect(find.text('Spotify expense'), findsOneWidget);
    expect(find.text('99.0'), findsOneWidget);
    expect(find.text('Privat Category'), findsOneWidget);
    expect(find.text('28-10-2023'), findsOneWidget);

  });
}
