import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper_add.dart';
import 'package:polybudget/features/home/presentation/settings_form.dart';
import 'package:provider/provider.dart';

import '../../../database.dart';
import '../../authenticate/domain/user.dart';
import '../domain/budget.dart';
import 'BudgetTile.dart';
import 'budget_settings_form.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});

  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final MyUser? user = args['user'];


    return StreamProvider<List<Budget?>?>.value(
      value: DatabaseService(uid: user?.uid).userBudget,
      initialData: const [],
      child: Consumer<List<Budget?>?>(
        builder: (context, myBudget, child){
          return HomeWrapperAdd(
            content: Column(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: myBudget?.length,
                  itemBuilder: (context, index){
                    return BudgetTile(budget: myBudget![index], user: user!);
                  },
                ),
              ],
            ), options: const BudgetSettingsForm(),
          );
        }


      ),
    );

  }
}
