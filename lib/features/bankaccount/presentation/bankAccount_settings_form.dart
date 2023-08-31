import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/constants.dart';
import 'package:polybudget/common_widgets/presentation/loading.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:provider/provider.dart';

class BankAccountSettingsForm extends StatefulWidget {
  const BankAccountSettingsForm({super.key});

  @override
  State<BankAccountSettingsForm> createState() => _BankAccountSettingsFormState();
}

class _BankAccountSettingsFormState extends State<BankAccountSettingsForm> {

  final _formkey = GlobalKey<FormState>();

  // form values
  late String? _currentName = "New Bank Accounts";

  @override
  Widget build(BuildContext context) {

    void close(){
      Navigator.pop(context);
    }

    // access to the current user logged in
    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

    return Form(
      key: _formkey,

      child: Column(
        children: [
          const Text(
            'Create new bank account',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0,),
          TextFormField(
            initialValue: _currentName,
            decoration: textInputDecoration, // constant.dart
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() {
              _currentName = val;
            }),
          ),
          const SizedBox(height: 20.0,),

          // update button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[400],
            ),
            onPressed: () async {
              if(_formkey.currentState!.validate()){
                // use the created budget to assign it to the user ID document in firestore
                await user?.createBankAccount(bankAccountName: _currentName!);
                close(); // Navigate.pop(context)
              }
            },
            child: const Text('Create account', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
