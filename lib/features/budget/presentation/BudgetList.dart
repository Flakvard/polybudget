import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../database.dart';
import '../../authenticate/application/auth.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});



  @override
  State<BudgetList> createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  @override
  Widget build(BuildContext context) {

    return const Text('hello');
    // Accessing data from database.dart
    // final myUser = Provider.of<List<MyUser?>?>(context) ?? [];
    // if(myUser != null){
    //   myUser.forEach((user) {
    //     print(user!.uid);
    //     print(user!.name);
    //     print(user!.email);
    //   });
    // }

    // return ListView.builder(
    //   itemCount: myUser?.length,
    //   itemBuilder: (context, index){
    //     return UserTile(user: myUser![index]);
    //   },
    // );

  }
}
