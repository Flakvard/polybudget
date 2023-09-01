import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/constants.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';

class BankAccountUpdateSettForm extends StatefulWidget {

  final BankAccount? bankAccount;
  final MyUser? user;

  const BankAccountUpdateSettForm({super.key, this.bankAccount, this.user});

  @override
  State<BankAccountUpdateSettForm> createState() => _BankAccountUpdateSettFormState();
}

class _BankAccountUpdateSettFormState extends State<BankAccountUpdateSettForm> {
  @override
  Widget build(BuildContext context) {

    // form values
    late String? _currentName;

    final _formkey = GlobalKey<FormState>();

    void close(){
      Navigator.pop(context);
    }

    return Form(
      key: _formkey,

      child: Column(
        children: [
          const Text(
            'Update bank account information',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0,),
          TextFormField(
            initialValue: widget.bankAccount?.name,
            decoration: textInputDecoration, // constant.dart
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => _currentName = val),

          const SizedBox(height: 20.0,),

          // update button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[400],
            ),
            onPressed: () async {
              if(_formkey.currentState!.validate()){
                widget.user!.updateBankAccount(
                    bankId: widget.bankAccount!.id,
                    newName: _currentName ?? widget.bankAccount!.name);

                close(); // Navigate.pop(context)
              }
            },
            child: const Text('Update account', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
