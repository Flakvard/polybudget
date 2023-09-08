import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper_add.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/transaction/presentation/transaction_options_by_bank_account.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/presentation/constants.dart';
import '../../authenticate/domain/user.dart';
import '../../bankaccount/domain/bankAccount.dart';
import '../../category/domain/category.dart' as c;


class TransactionForm extends StatefulWidget {

  final BankAccount? bank;
  final c.Category? category;
  final Budget? budget;

  const TransactionForm({super.key, required this.bank, required this.category, required this.budget});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formkey = GlobalKey<FormState>();

  String _currentName = 'New transaction';
  double _currentValue = 0.0;
  DateTime firstDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  DateTime lastDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+14);
  // form values

  @override
  Widget build(BuildContext context) {

    BankAccount? selectedBankAccount = widget.bank; // Initialize with an empty string
    c.Category? selectedCategory = widget.category; // Initialize with an empty string
    Budget? selectedBudget = widget.budget; // Initialize with an empty string

    void close(){
      Navigator.pop(context);
    }

    // access to the current user logged in
    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null
    // final budgetsSnapshot = DatabaseService(uid: user?.uid).userBudget;
    // List<Budget> budgets = budgetsSnapshot as List<Budget>;
    // for (Budget budget in budgets){
    //   print(budget.name);
    // }

    return MultiProvider(
    providers: [
      StreamProvider<List<Budget?>?>.value(
        value: DatabaseService(uid: user?.uid).userBudget,
        initialData: const []
      ),
      StreamProvider<List<c.Category?>?>.value(
        value: DatabaseService(uid: user?.uid).userCategory,
        initialData: const []
      ),
      StreamProvider<List<BankAccount?>?>.value(
        value: DatabaseService(uid: user?.uid).userBankAccount,
        initialData: const []
      ),
    ],
      child: HomeWrapperAdd(
        content: Form(
          key: _formkey,

          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10.0,),
                TextFormField(
                  initialValue: _currentName,
                  decoration: textInputDecoration, // constant.dart
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                const SizedBox(height: 10.0,),
                InputDatePickerFormField(
                    firstDate: firstDate,
                    lastDate: lastDate),
                const SizedBox(height: 10.0,),
                TextFormField(
                  initialValue: _currentValue.toString(),
                  decoration: textInputDecoration, // constant.dart
                  validator: (val) => val!.isEmpty ? 'Please enter a value' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                const SizedBox(height: 10.0,),
                Consumer<List<BankAccount?>?>(
                builder: (context, bankAccounts, child) {
                  // Create a list of DropdownMenuItem<BankAccount>
                  final dropdownItems = bankAccounts
                      ?.where((bankAccount) => bankAccount != null)
                      .map((bankAccount) {
                        return DropdownMenuItem<BankAccount?>(
                          value: bankAccount, // Use a default value or an empty string if ID is null
                          child: Text('BankAccount: ${bankAccount!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                        );
                  }).toList();
                  // Add an additional item for "no bank account"
                  dropdownItems?.insert(0, const DropdownMenuItem<BankAccount?>(
                    value: null, // Empty BankAccount for "no bank account"
                    child: const Text('No Bank Account'),
                  ));

                  return Column (
                  children: [
                    const SizedBox(height: 10.0,),
                    // List of bank accounts the user has
                    DropdownButtonFormField<BankAccount?>(
                      decoration: textInputDecoration,
                      value: selectedBankAccount ?? bankAccounts![0], // Set the selected bank account
                      items: dropdownItems,
                      onChanged: (newValue) =>
                          setState(() => selectedBankAccount = newValue!),
                    ),
                    const SizedBox(height: 10.0,),
                  ],
                  );
                }),

                Consumer<List<c.Category?>?>(
                    builder: (context, categories, child) {
                      // Create a list of DropdownMenuItem<BankAccount>
                      final dropdownItems = categories?.where((category) => category != null).map((category) {
                        return DropdownMenuItem<c.Category>(
                          value: category, // Use a default value or an empty string if ID is null
                          child: Text('Category: ${category!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                        );
                      }).toList();
                      // Add an additional item for "no bank account"
                      dropdownItems?.insert(0, const DropdownMenuItem<c.Category>(
                        value: null, // Empty string for "no bank account"
                        child: Text('No Category'),
                      ));
                      return Column (
                        children: [
                          const SizedBox(height: 10.0,),
                          // List of bank accounts the user has
                          DropdownButtonFormField<c.Category>(
                            decoration: textInputDecoration,
                            value: selectedCategory ?? categories![0], // Set the selected bank account
                            items: dropdownItems,
                            onChanged: (newValue) =>
                                setState(() => selectedCategory = newValue!),
                          ),
                          const SizedBox(height: 10.0,),
                        ],
                      );
                    }),

                Consumer<List<Budget?>?>(
                    builder: (context, budgets, child) {
                      // Create a list of DropdownMenuItem<BankAccount>
                      final dropdownItems = budgets?.where((budget) => budget != null).map((budget) {
                        return DropdownMenuItem<Budget>(
                          value: budget, // Use a default value or an empty string if ID is null
                          child: Text('Budget: ${budget!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                        );
                      }).toList();
                      // Add an additional item for "no bank account"
                      dropdownItems?.insert(0, const DropdownMenuItem<Budget>(
                        value: null, // Empty string for "no bank account"
                        child: Text('No Budget'),
                      ));
                      return Column (
                        children: [
                          const SizedBox(height: 10.0,),
                          // List of bank accounts the user has
                          DropdownButtonFormField<Budget>(
                            decoration: textInputDecoration,
                            value: selectedBudget ?? budgets![0], // Set the selected bank account
                            items: dropdownItems,
                            onChanged: (newValue) =>
                                setState(() => selectedBudget = newValue!),
                          ),
                          const SizedBox(height: 10.0,),
                        ],
                      );
                    }),
                const SizedBox(height: 10.0,),

                // update button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  onPressed: () async {
                    //     amount: amount,
                    //     budget: budget,
                    //     category: category,
                    //     bankAccount: bankAccount,
                    //     date: date,
                    //     recurring: recurring,
                    //     transactionType: transactionType);
                    print('transaction name: $_currentName');
                    print('bank name: ${selectedBankAccount?.name} and the id is ${selectedBankAccount?.id}');
                    print('budget name: ${selectedBudget?.name} and the id is ${selectedBudget?.id}');
                    print('category name: ${selectedCategory?.name} and the id is ${selectedCategory?.id}');

                    if(_formkey.currentState!.validate()){
                      // use the created budget to assign it to the user ID document in firestore
                      // await user?.createTransaction(
                      //     transactionName: transactionName,
                      //     amount: amount,
                      //     budget: budget,
                      //     category: category,
                      //     bankAccount: bankAccount,
                      //     date: date,
                      //     recurring: recurring,
                      //     transactionType: transactionType);
                      close(); // Navigate.pop(context)
                    }
                  },
                  child: const Text('Create transaction', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ), options: const TransactionSettingsForm(),

      ),
    );
  }
}
