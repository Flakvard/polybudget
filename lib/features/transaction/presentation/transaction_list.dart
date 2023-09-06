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

  late String year;
  late String month;
  late String bankID;
  @override
  void initState() {
    super.initState();
    // Initialize year and month with default values
    year = DateTime.now().year.toString();
    month = DateTime.now().month.toString();
    bankID = '';
  }



  @override
  Widget build(BuildContext context) {


    // Retrieve the user class from the menu in Home()
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final MyUser user = args['user'];



    return StreamProvider<List<t.Transaction?>?>.value(
      value: bankID == ''
          ? DatabaseService(uid: user?.uid).allUserTransactions(year: year, month: month)
          : DatabaseService(uid: user?.uid).userTransactionsByAccount(
        bankAccountId: bankID,
        year: year,
        month: month,
      ),
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
              filter: TransactionFilterForm(
                year: year,
                month: month,
                user: user,
                bankId: bankID,
                  onFilterChanged: (newYear, newMonth, newBankId) {
                    // Update the year and month in this widget
                    setState(() {
                      year = newYear;
                      month = newMonth;
                      bankID = newBankId;
                    });
                  }),
            );
          }
      ),
    );
  }
}
