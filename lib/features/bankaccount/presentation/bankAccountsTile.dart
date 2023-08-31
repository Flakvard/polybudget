import 'package:flutter/material.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';

class BankAccountTile extends StatelessWidget {

  final BankAccount? bankAccount;

  const BankAccountTile({super.key, this.bankAccount});

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
          title: Text(bankAccount!.name),
          subtitle: Text('id: ${bankAccount?.id}'),
          onTap: () {
            Navigator.pushNamed(context, '/transactionList',arguments: bankAccount?.id);
            print('Go to transaction page and provide bankaccount ID for firestore');
          },
        ),
      ),
    );
  }
}
