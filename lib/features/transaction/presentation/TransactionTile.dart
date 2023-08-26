import 'package:flutter/material.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart' as c;

class TransactionTile extends StatelessWidget {
  final c.Transaction? transaction;
  const TransactionTile({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(transaction!.text),
          subtitle: Text('id: ${transaction?.id}'),
        ),
      ),
    );
  }
}
