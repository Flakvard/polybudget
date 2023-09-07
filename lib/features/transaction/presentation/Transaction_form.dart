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

  final String bankId;
  final String categoryId;
  final String budgetId;

  const TransactionForm({super.key, required this.bankId, required this.categoryId, required this.budgetId});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formkey = GlobalKey<FormState>();

  String _currentName = 'New bank account';
  // form values
  late String selectedBankAccountId = widget.bankId; // Initialize with an empty string
  late String selectedCategoryId = widget.categoryId; // Initialize with an empty string
  late String selectedBudgetId = widget.budgetId; // Initialize with an empty string

  @override
  Widget build(BuildContext context) {

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

          child: Column(
            children: [
              Consumer<List<BankAccount?>?>(
              builder: (context, bankAccounts, child) {
                // Create a list of DropdownMenuItem<BankAccount>
                final dropdownItems = bankAccounts?.where((bankAccount) => bankAccount != null).map((bankAccount) {
                  return DropdownMenuItem<String>(
                    value: bankAccount!.id ?? '', // Use a default value or an empty string if ID is null
                    child: Text('BankAccount: ${bankAccount!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                  );
                }).toList();
                // Add an additional item for "no bank account"
                dropdownItems?.insert(0, const DropdownMenuItem<String>(
                  value: '', // Empty string for "no bank account"
                  child: Text('No Bank Account'),
                ));
                return Column (
                children: [
                  const SizedBox(height: 20.0,),
                  // List of bank accounts the user has
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    value: selectedBankAccountId, // Set the selected bank account
                    items: dropdownItems,
                    onChanged: (newValue) =>
                        setState(() => selectedBankAccountId = newValue!),
                  ),
                  const SizedBox(height: 20.0,),
                ],
                );
              }),

              Consumer<List<c.Category?>?>(
                  builder: (context, categories, child) {
                    // Create a list of DropdownMenuItem<BankAccount>
                    final dropdownItems = categories?.where((category) => category != null).map((category) {
                      return DropdownMenuItem<String>(
                        value: category!.id ?? '', // Use a default value or an empty string if ID is null
                        child: Text('Category: ${category!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                      );
                    }).toList();
                    // Add an additional item for "no bank account"
                    dropdownItems?.insert(0, const DropdownMenuItem<String>(
                      value: '', // Empty string for "no bank account"
                      child: Text('No Category'),
                    ));
                    return Column (
                      children: [
                        const SizedBox(height: 20.0,),
                        // List of bank accounts the user has
                        DropdownButtonFormField<String>(
                          decoration: textInputDecoration,
                          value: selectedCategoryId, // Set the selected bank account
                          items: dropdownItems,
                          onChanged: (newValue) =>
                              setState(() => selectedCategoryId = newValue!),
                        ),
                        const SizedBox(height: 20.0,),
                      ],
                    );
                  }),

              Consumer<List<Budget?>?>(
                  builder: (context, budgets, child) {
                    // Create a list of DropdownMenuItem<BankAccount>
                    final dropdownItems = budgets?.where((budget) => budget != null).map((budget) {
                      return DropdownMenuItem<String>(
                        value: budget!.id ?? '', // Use a default value or an empty string if ID is null
                        child: Text('Budget: ${budget!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                      );
                    }).toList();
                    // Add an additional item for "no bank account"
                    dropdownItems?.insert(0, const DropdownMenuItem<String>(
                      value: '', // Empty string for "no bank account"
                      child: Text('No Budget'),
                    ));
                    return Column (
                      children: [
                        const SizedBox(height: 20.0,),
                        // List of bank accounts the user has
                        DropdownButtonFormField<String>(
                          decoration: textInputDecoration,
                          value: selectedBudgetId, // Set the selected bank account
                          items: dropdownItems,
                          onChanged: (newValue) =>
                              setState(() => selectedBudgetId = newValue!),
                        ),
                        const SizedBox(height: 20.0,),
                      ],
                    );
                  }),
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
        ), options: const TransactionSettingsForm(),

      ),
    );
  }
}


// AlertDialog(
// title: const Text('Enter Data'),
// content: const SingleChildScrollView(
// child: Column(
// children: [
// // Add your form fields here
// TextField(
// decoration: textInputDecoration,
// ),
// TextField(
// decoration: textInputDecoration,
// ),
// ],
// ),
// ),
// actions: [
// ElevatedButton(
// onPressed: () {
// // Handle form submission here
// // You can access form data and perform actions
// Navigator.pop(context); // Close the dialog
// },
// child: const Text('Submit'),
// ),
// ],
// )