import 'package:flutter/material.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';

import '../../../common_widgets/presentation/constants.dart';

class BudgetUpdateSettForm extends StatefulWidget {

  final Budget? budget;
  final MyUser? user;

  const BudgetUpdateSettForm({super.key, required this.budget, required this.user});

  @override
  State<BudgetUpdateSettForm> createState() => _BudgetUpdateSettFormState();
}

class _BudgetUpdateSettFormState extends State<BudgetUpdateSettForm> {
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
            'Update budget information',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0,),
          TextFormField(
              initialValue: widget.budget?.name,
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
                widget.user!.updateBudget(
                    budgetId: widget.budget!.id,
                    newName: _currentName ?? widget.budget!.name);

                close(); // Navigate.pop(context)
              }
            },
            child: const Text('Update budget', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
