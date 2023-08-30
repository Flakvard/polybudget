import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:provider/provider.dart';
import 'bankAccountsTile.dart';

class BankAccountList extends StatelessWidget {
  const BankAccountList({super.key});

  @override
  Widget build(BuildContext context) {

    final bankAccounts = Provider.of<List<BankAccount?>?>(context) ?? [];

    return HomeWrapper(
      content: Column(
        children: [
          const SizedBox(height: 12.0,),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: bankAccounts?.length,
            itemBuilder: (context, index){
              return BankAccountTile(bankAccount: bankAccounts![index]);
            },
          ),
        ],
      )
    );
  }
}
