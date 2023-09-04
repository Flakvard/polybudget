import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper_settings.dart';
import 'package:polybudget/common_widgets/presentation/loading.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;
import 'package:polybudget/features/home/presentation/settings_form.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart';
import 'package:polybudget/features/transaction/presentation/TransactionCardContent.dart';
import 'package:polybudget/features/transaction/presentation/TransactionTile.dart';
import 'package:polybudget/features/transaction/presentation/transaction_filter_form.dart';
import 'package:polybudget/features/transaction/presentation/transaction_options_by_bank_account.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/budget/domain/budget.dart';

import '../../../common_widgets/presentation/home_wrapper_add.dart';

class TransactionListByBankAcc extends StatefulWidget {
  const TransactionListByBankAcc({super.key});

  @override
  State<TransactionListByBankAcc> createState() => _TransactionListByBankAccState();
}

class _TransactionListByBankAccState extends State<TransactionListByBankAcc> {

  @override
  Widget build(BuildContext context) {

    // Retrieve the bank account ID from the tap argument in BankAccountTile()
    final String? bankAccountId = ModalRoute.of(context)?.settings.arguments as String?;

    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

    final String year = DateTime.now().year.toString();
    // final String month = DateTime.now().month.toString();
    const String month = '8';
    // List<Transaction?> transactions =

    return HomeWrapperOptions(
      content: SingleChildScrollView(
          child: StreamBuilder<List<Transaction?>?>(
            stream: DatabaseService(uid: user?.uid).userTransactionsByAccount(
                bankAccountId: bankAccountId!, year: year, month: month),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const Loading(); // Loading indicator
              }

              List<Transaction?> transactions = snapshot.data!;

              for (var transaction in transactions){
                print(transaction.toString());
              }

              // Build your UI using the transactions list
              // ...

              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionCardContent(transaction: transactions[index]);
                },
              );
            }),
      ),
     options: const TransactionSettingsForm(),
     filter: const TransactionFilterForm());
  }
}