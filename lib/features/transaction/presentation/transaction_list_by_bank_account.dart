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
import 'package:provider/provider.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/budget/domain/budget.dart';

import '../../../common_widgets/presentation/home_wrapper_add.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {

  // late List<Transaction> transactions = [
  //   Transaction(id: "1", budget: Budget(name: "Personal budget", id: "1"), text: "Groceries expense",amount: 184.23,category: c.Category(id: "1", name: "Food Category"),date: DateTime.parse("2023-10-18"),transactionType: TransactionType.expected,recurring: false,bankAccount: BankAccount(id: "1",name: "Matkortið")),
  //   Transaction(id: "2", budget: Budget(name: "Personal budget", id: "2"), text: "MovieNight expense",amount: 14,category: c.Category(id: "2", name: "Privat Category"),transactionType: TransactionType.expected,bankAccount: BankAccount(id: "1",name: "Matkortið")),
  //   Transaction(id: "3", budget: Budget(name: "Personal budget", id: "3"), text: "Hotel expense",amount: 84.3,category: c.Category(id: "3", name: "Vacation Category"),date: DateTime.parse("2023-10-18"),transactionType: TransactionType.actual,recurring: false,bankAccount: BankAccount(id: "1",name: "Matkortið")),
  //   Transaction(id: "4", budget: Budget(name: "Personal budget", id: "4"), text: "Spotify expense",amount: 99,category: c.Category(id: "4", name: "Privat Category"),transactionType: TransactionType.actual, date: DateTime.parse("2023-10-18"),recurring: true, bankAccount: BankAccount(id: "1",name: "Matkortið")),
  // ];

  @override
  Widget build(BuildContext context) {

    // Retrieve the user class from the menu in Home()
    // final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final MyUser user = args['user'];

    // Retrieve the bank account ID from the tap argument in BankAccountTile()
    final String? bankAccountId = ModalRoute.of(context)?.settings.arguments as String?;

    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null
    // final myBudget = Provider.of<List<Budget?>?>(context) ?? [];
    // final categories = Provider.of<List<c.Category?>?>(context) ?? [];
    // final bankAccounts = Provider.of<List<BankAccount?>?>(context) ?? [];

    final String year = DateTime.now().year.toString();
    // final String month = DateTime.now().month.toString();
    const String month = '8';
    // List<Transaction?> transactions =

    return HomeWrapperOptions(
      content: SingleChildScrollView(
          child: StreamBuilder<List<Transaction?>?>(
            stream: DatabaseService(uid: user?.uid).userTransactions(
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
     options: const SettingsForm());
  }
}