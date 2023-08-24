import 'package:flutter/material.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart';

class TransactionCardContent extends StatelessWidget {
  final Transaction transaction;
  final Function()? delete;
  // constructor
  // const TransactionCardContent(this.transaction, {Key? key}) : super(key: key);
  const TransactionCardContent({super.key, required this.transaction, this.delete});

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
              transaction.amount.toString(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.red[600],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              transaction.category.name,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              transaction.getFormatDate(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8.0),
            TextButton.icon(
              // TODO: test delete button inside card
                onPressed: (){delete!();},
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}

