import 'package:flutter/material.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:provider/provider.dart';
import 'bankAccountsTile.dart';

class BankAccountList extends StatelessWidget {
  const BankAccountList({super.key});

  @override
  Widget build(BuildContext context) {

    final bankAccounts = Provider.of<List<BankAccount?>?>(context) ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: bankAccounts?.length,
      itemBuilder: (context, index){
        return BankAccountTile(bankAccount: bankAccounts![index]);
      },
    );
  }
}
