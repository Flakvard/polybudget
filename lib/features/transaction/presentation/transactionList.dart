import 'package:flutter/material.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart';
import 'package:polybudget/features/transaction/presentation/TransactionCardContent.dart';

import '../../budget/domain/budget.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  late List<Transaction> transactions = [
    Transaction(id: "1", budget: Budget(name: "Personal budget", id: "1"), text: "Groceries expense",amount: 184.23,category: Category(id: "1", name: "Food Category"),date: DateTime.parse("2023-10-18"),transactionType: TransactionType.expected,recurring: false,bankAccount: BankAccount(id: "1",name: "Matkortið")),
    Transaction(id: "2", budget: Budget(name: "Personal budget", id: "2"), text: "MovieNight expense",amount: 14,category: Category(id: "2", name: "Privat Category"),transactionType: TransactionType.expected,bankAccount: BankAccount(id: "1",name: "Matkortið")),
    Transaction(id: "3", budget: Budget(name: "Personal budget", id: "3"), text: "Hotel expense",amount: 84.3,category: Category(id: "3", name: "Vacation Category"),date: DateTime.parse("2023-10-18"),transactionType: TransactionType.actual,recurring: false,bankAccount: BankAccount(id: "1",name: "Matkortið")),
    Transaction(id: "4", budget: Budget(name: "Personal budget", id: "4"), text: "Spotify expense",amount: 99,category: Category(id: "4", name: "Privat Category"),transactionType: TransactionType.actual, date: DateTime.parse("2023-10-18"),recurring: true, bankAccount: BankAccount(id: "1",name: "Matkortið")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text('PolyBudget'),
        centerTitle: true,
        elevation: 0.0, // removes shadow
      ),
      body: SingleChildScrollView(
        child: Column(
            children: transactions.map((transaction) => TransactionCardContent(
                transaction: transaction,
                // TODO: test delete button inside list
                delete: () {
                  setState(() {
                    print('list');
                    transactions.remove(transaction);
                  });
              }
            )).toList()
        ),
      ),

    );
  }
}


