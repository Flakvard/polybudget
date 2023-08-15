import 'package:flutter/material.dart';
import 'package:polybudget/transactions.dart';

class TransactionCardContent extends StatelessWidget {
  final Transaction transaction;
  // constructor
  // const TransactionCardContent(this.transaction, {Key? key}) : super(key: key);
  const TransactionCardContent({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              transaction.text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              // double.parse(transaction.total).toString(),
              transaction.total.toString(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red[600],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              transaction.category,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              transaction.date,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

