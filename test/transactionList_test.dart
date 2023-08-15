import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:polybudget/transactionList.dart'; // Import your TransactionList widget
import 'package:polybudget/transactions.dart';

void main() {
  testWidgets('Transaction content displays correctly', (WidgetTester tester) async {
    final List<Transaction> transactions = [
      Transaction(text: "Groceries expense",total: 184.23,category: "Food Category",date: "18-10-2023",recurring: false,transactionType: "Actual",bankAccount: "Matkortið"),
      Transaction(text: "MovieNight expense",total: 14,category: "Privat Category",transactionType: "Actual",bankAccount: "Matkortið"),
      Transaction(text: "Hotel expense",total: 84.3,category: "Vacation Category",date: "18-10-2023",recurring: false,transactionType: "Actual",bankAccount: "Matkortið"),
      Transaction(text: "Spotify expense",total: 99,category: "Privat Category",date: "28-10-2023",recurring: true,transactionType: "Actual",bankAccount: "Matkortið"),
    ];

    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transactions[0])));
    expect(find.text('Groceries expense'), findsOneWidget);
    expect(find.text('184.23'), findsOneWidget);
    expect(find.text('Food Category'), findsOneWidget);
    expect(find.text('18-10-2023'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transactions[1])));
    expect(find.text('MovieNight expense'), findsOneWidget);
    expect(find.text('14.0'), findsOneWidget);
    expect(find.text('Privat Category'), findsOneWidget);
    expect(find.text('15-08-2023'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transactions[2])));
    expect(find.text('Hotel expense'), findsOneWidget);
    expect(find.text('84.3'), findsOneWidget);
    expect(find.text('Vacation Category'), findsOneWidget);
    expect(find.text('18-10-2023'), findsOneWidget);
    await tester.pumpWidget(MaterialApp(home: TransactionCardContent(transactions[3])));
    expect(find.text('Spotify expense'), findsOneWidget);
    expect(find.text('99.0'), findsOneWidget);
    expect(find.text('Privat Category'), findsOneWidget);
    expect(find.text('28-10-2023'), findsOneWidget);

  });
}
