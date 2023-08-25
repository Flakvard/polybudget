import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database.dart';
import '../../authenticate/application/auth.dart';
import '../domain/budget.dart';
import 'BudgetTile.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {

  @override
  Widget build(BuildContext context) {
    print('Hello world');
    // Accessing data from database.dart
    final myBudget = Provider.of<List<Budget?>?>(context) ?? [];
    print('the lenght of budgets is: ${myBudget.length}');
     if(myBudget != null){
       for (var budget in myBudget) {
         print(budget!.id);
         print(budget!.name);
       }
     }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: myBudget?.length,
      itemBuilder: (context, index){
        return BudgetTile(budget: myBudget![index]);
      },
    );

  }
}
