import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common_widgets/presentation/constants.dart';
import '../../../database.dart';
import '../../authenticate/domain/user.dart';
import '../../bankaccount/domain/bankAccount.dart';
import '../../budget/domain/budget.dart';
import '../../category/domain/category.dart' as c;

class FilterWidget extends StatefulWidget {

  final MyUser? user;

  const FilterWidget({super.key, required this.user});

@override
State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  String selectedDateRange = 'Week';
  // String selectedBudget = 'All Budgets';
  // String selectedBankAccount = 'All Bank Accounts';

  final BankAccount? noBankAccount = BankAccount(id: '', name: 'No Bank Account');
  final c.Category? noCategory = c.Category(id: '', name: 'No Category');
  final Budget? noBudget = Budget(id: '', name: 'No Budget');
  BankAccount? selectedBankAccount; // Initialize with an empty string
  c.Category? selectedCategory; // Initialize with an empty string
  Budget? selectedBudget;// Initialize with an empty string
  @override
  Widget build(BuildContext context) {


    void close(){
      Navigator.pop(context);
    }


    // access to the current user logged in
    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

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
    child: Column(
      children: [
        Row(
          children: [
            // Date Range Dropdown
            Flexible(
              child: DropdownButtonFormField<String>(
                decoration: textInputDecoration,
                value: selectedDateRange,
                onChanged: (newValue) {
                  setState(() {
                    selectedDateRange = newValue!;
                    // Update chart data here based on the selected date range.
                  });
                },
                items: ['Day', 'Week', 'Month', 'Quarter', 'Year']
                    .map((range) => DropdownMenuItem<String>(
                  value: range,
                  child: Text(range),
                ))
                    .toList(),
              ),
            ),

            // Budget Dropdown
            // Pick a budget form
            Flexible(
              child: Consumer<List<Budget?>?>(
                  builder: (context, budgets, child) {
                    // Create a list of DropdownMenuItem<BankAccount>
                    final dropdownItems = budgets?.where((budget) => budget != null).map((budget) {
                      return DropdownMenuItem<Budget>(
                        value: budget, // Use a default value or an empty string if ID is null
                        child: Text(budget!.name ?? 'Unnamed',overflow: TextOverflow.ellipsis,), // Provide a default name if it's null
                      );
                    }).toList();
                    dropdownItems?.insert(0, DropdownMenuItem<Budget>(
                      value: noBudget, // Empty string for "no budget"
                      child: Text(noBudget!.name, overflow: TextOverflow.ellipsis,),
                    ));
                    return DropdownButtonFormField<Budget>(
                          decoration: textInputDecoration,
                          //decoration: InputDecoration(fillColor: Colors.white,filled: true),
                          value: selectedBudget, // Set the selected bank account
                          items: dropdownItems,
                          // validator: (newValue) => newValue == noBudget ? "Please select a budget" : null,
                          onChanged: (newValue) =>
                              setState(() => selectedBudget = newValue!),
                      isExpanded: true,
                    );
                  }),
            ),

            // Bank Account Dropdown
            // Pick a bank form
            Flexible(
              child: Consumer<List<BankAccount?>?>(
                  builder: (context, bankAccounts, child) {
                    // Create a list of DropdownMenuItem<BankAccount>
                    final dropdownItems = bankAccounts
                        ?.where((bankAccount) => bankAccount != null)
                        .map((bankAccount) {
                      return DropdownMenuItem<BankAccount?>(
                        value: bankAccount, // Use a default value or an empty string if ID is null
                        child: Text(bankAccount!.name ?? 'Unnamed',overflow: TextOverflow.ellipsis,), // Provide a default name if it's null
                      );
                    }).toList();
                    // Add an additional item for "no bank account"
                    dropdownItems?.insert(0, DropdownMenuItem<BankAccount?>(
                      value: noBankAccount, // Empty string for "no bank account"
                      child: Text(noBankAccount!.name,overflow: TextOverflow.ellipsis,),
                    ));

                    return DropdownButtonFormField<BankAccount?>(
                          decoration: textInputDecoration,
                          value: selectedBankAccount, // Set the selected bank account
                          items: dropdownItems,
                          //validator: (newValue) => newValue == noBankAccount ? "Please select a bank account" : null,
                          onChanged: (newValue) =>
                              setState(() => selectedBankAccount = newValue!),
                      isExpanded: true,
                    );
                  }),
            ),

            // Add navigation arrows or buttons here.
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () {
                //decrementWeek();
              },
            ),
            const SizedBox(width: 40,),
            const Text(
              //'Week $selectedWeek',
              'Week 36',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0
              ),
            ), // Display the selected time period
            const SizedBox(width: 30,),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 40.0,
              ),
              onPressed: () {
                //incrementWeek();
              },
            ),
          ],
        )
      ],
    ),
    );
  }
}
