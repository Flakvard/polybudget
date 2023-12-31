import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper_add.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:provider/provider.dart';
import '../../../database.dart';
import '../../authenticate/domain/user.dart';
import 'bankAccount_settings_form.dart';
import 'bankAccountsTile.dart';

class BankAccountList extends StatelessWidget {


  BankAccountList({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final MyUser? user = args['user'];

    // final bankAccounts = Provider.of<List<BankAccount?>?>(context) ?? [];


    return StreamProvider<List<BankAccount?>?>.value(
      value: DatabaseService(uid: user?.uid).userBankAccount,
      initialData: const [],
      child: Consumer<List<BankAccount?>?>(
        builder: (context, bankAccounts, child) {
            return HomeWrapperAdd(
              content: Column(
                children: [
                  const SizedBox(height: 12.0,),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: bankAccounts?.length ?? 0,
                    itemBuilder: (context, index) {
                      return BankAccountTile(bankAccount: bankAccounts![index], user: user);
                    },
                  ),
                ],
              ), options: const BankAccountSettingsForm(),
          );
        }),
    );
  }
}
