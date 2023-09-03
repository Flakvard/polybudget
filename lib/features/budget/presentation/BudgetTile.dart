import 'package:flutter/material.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';

class BudgetTile extends StatelessWidget {

  final Budget? budget;
  final MyUser user;

  const BudgetTile({super.key, required this.budget, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(budget!.name),
          subtitle: Text('id: ${budget?.id}'),
          trailing:  PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'update') {
                // Handle the "Update" option
              } else if (value == 'delete') {
                // Handle the "Delete" option
                user!.deleteBudget(budgetId: budget!.id);
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
        ),
      ),
    );
  }
}
