import 'package:flutter/material.dart';
import 'package:polybudget/features/budget/domain/budget.dart';

class BudgetTile extends StatelessWidget {

  final Budget? budget;

  const BudgetTile({super.key, this.budget});

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
        ),
      ),
    );
  }
}
