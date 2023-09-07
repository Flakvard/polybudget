import 'package:flutter/material.dart';

import 'Transaction_form.dart';

class TransactionFloatingButton extends StatelessWidget {
  const TransactionFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.pink[300],
      elevation: 0.0,
      //child: const Icon(Icons.add),
      // Add the PopupMenuButton for the dropdown menu
      // The items parameter should contain your menu items
      // The onSelected callback is called when a menu item is selected
      // Use itemBuilder to build the menu items
      child: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'advanced') {
            // Show the "New Transaction Advanced" dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TransactionForm(
                  bankId: '',
                  categoryId: '',
                  budgetId: '',
                ); // Display the advanced form
              },
            );
          } else if (value == 'by_bank_account') {
            // Show the "New Transaction by Bank Account" dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Text('');//NewTransactionByBankAccountDialog(); // Display the bank account form
              },
            );
          } else if (value == 'by_budget') {
            // Show the "New Transaction by Budget" dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Text('');//NewTransactionByBudgetDialog(); // Display the budget form
              },
            );
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'by_bank_account',
            child: ListTile(
              leading:
                  Icon(Icons.account_balance_wallet), // Replace with your icon
              title: Text('New Transaction by Bankaccount'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'by_budget',
            child: ListTile(
              leading: Icon(Icons.balance), // Replace with your icon
              title: Text('New Transaction by Budget'),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'advanced',
            child: ListTile(
              leading: Icon(Icons.credit_card), // Replace with your icon
              title: Text('New Transaction advanced'),
            ),
          ),
          // Add more menu items as needed
        ],
      ),
    );
  }
}
