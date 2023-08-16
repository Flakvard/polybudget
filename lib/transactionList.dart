import 'package:flutter/material.dart';
import 'package:polybudget/transactions.dart';
import 'package:polybudget/TransactionCardContent.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  late List<Transaction> transactions = [
    Transaction(text: "Groceries expense",total: 184.23,category: "Food Category",date: "18-10-2023",recurring: false,transactionType: "Actual",bankAccount: "Matkortið"),
    Transaction(text: "MovieNight expense",total: 14,category: "Privat Category",transactionType: "Actual",bankAccount: "Matkortið"),
    Transaction(text: "Hotel expense",total: 84.3,category: "Vacation Category",date: "18-10-2023",recurring: false,transactionType: "Actual",bankAccount: "Matkortið"),
    Transaction(text: "Spotify expense",total: 99,category: "Privat Category",date: "28-10-2023",recurring: true,transactionType: "Actual",bankAccount: "Matkortið"),
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


