// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'home.dart';
import 'transactions.dart';

void main() {
  runApp(const MaterialApp(
    home: TransactionList()
  ));
}

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

  Widget transactionTemplate(transaction){
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
      child: Column(
        children: [
          Text(
            transaction.text,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 6.0,),
          Text(
            // double.parse(transaction.total).toString(),
            transaction.total.toString(),
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 6.0,),
          Text(
            transaction.category,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 6.0,),
          Text(
            transaction.date,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.pink[200],
        title: const Text('PolyBudget'),
        centerTitle: true,
        elevation: 0.0, // removes shadow
      ),
      body: Column(
        children: transactions.map((transaction) => transactionTemplate(transaction)).toList()
      ),

    );
  }
}


