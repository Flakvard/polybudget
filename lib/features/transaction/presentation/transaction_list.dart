import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper_settings.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart' as t;
import 'package:polybudget/features/transaction/presentation/TransactionTile.dart';
import 'package:polybudget/features/transaction/presentation/transaction_filter_form.dart';
import 'package:provider/provider.dart';

import '../../../database.dart';
import 'TransactionCardContent.dart';
import 'package:polybudget/features/transaction/presentation/transaction_options_by_bank_account.dart';


class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {


    // Retrieve the user class from the menu in Home()
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final MyUser user = args['user'];

    //final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

    final String year = DateTime.now().year.toString();
    // final String month = DateTime.now().month.toString();
    const String month = '8';

    return StreamProvider<List<t.Transaction?>?>.value(
      value: DatabaseService(uid: user?.uid).allUserTransactions(year: year, month: month),
      initialData: const [],
      child: Consumer<List<t.Transaction?>?>(
          builder: (context, transactions, child) {
            return HomeWrapperOptions(
              content: Column(
                children: [
                  const SizedBox(height: 12.0,),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: transactions?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TransactionCardContent(transaction: transactions?[index]);
                    },
                  ),
                ],
              ),
              options: const TransactionSettingsForm(),
              filter: const TransactionFilterForm(),
            );
          }),
    );
  }
}
