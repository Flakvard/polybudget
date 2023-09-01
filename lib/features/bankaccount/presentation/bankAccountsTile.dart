import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';

import '../../../common_widgets/presentation/constants.dart';
import 'bankAccount_update_settings_form.dart';

class BankAccountTile extends StatelessWidget {

  final BankAccount? bankAccount;
  final MyUser? user;

  const BankAccountTile({super.key, this.bankAccount, required this.user});

  @override
  Widget build(BuildContext context) {

    final List<String> sugars = ['Delete','Update']; // dropdown values

    String? errorMsg = "";

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
          trailing:  PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'update') {
                  // Handle the "Update" option
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: BankAccountUpdateSettForm(
                          bankAccount: bankAccount,
                          user: user,
                        ),
                        backgroundColor: Colors.grey[200],
                      );
                    },
                  );
                } else if (value == 'delete') {
                // Handle the "Delete" option
                  user!.deleteBankAccount(bankId: bankAccount!.id);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                      value: 'update',
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.edit),
                        title: Text('Update'),
                      ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ),
                  ),
              ],
          ),
          onTap: () {
            Navigator.pushNamed(context, '/transactionList',arguments: bankAccount?.id);
            print('Go to transaction page and provide bankaccount ID for firestore');
          },

        ),
      ),
    );
  }
}
