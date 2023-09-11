import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;
import 'package:polybudget/features/category/presentation/CategoryList.dart';
import 'package:polybudget/features/home/presentation/menu.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/home/presentation/settings_form.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart';
import 'package:provider/provider.dart';

import 'package:polybudget/features/budget/presentation/BudgetList.dart';
import '../../bankaccount/presentation/BankAccountList.dart';
import '../../budget/domain/budget.dart';
import 'UserInfoList.dart';

class Home extends StatelessWidget {
  Home({super.key});


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: const SettingsForm(),
        );
      });
    }

    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

    return MultiProvider(
      providers: [
        StreamProvider<List<MyUser?>?>.value(
          // returns the collection of user db from firestore
          value: DatabaseService().myUsers,
          initialData: const []
        ),
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
        child: Scaffold( // layout widget to flesh out general layout of the app. Check scaffold class in docs.
          key: _scaffoldKey, // Assign the scaffold key
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            title: const Text('PolyBudget'),
            centerTitle: true,
            backgroundColor: Colors.pink[300],
            elevation: 0.0, // removes shadow
            // adding hamburger menu icon
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Open the drawer when the icon is clicked
                _scaffoldKey.currentState?.openDrawer(); // Use ?. to handle null currentState
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => _showSettingsPanel(),

              ),
            ],
          ),
          body: const Column(
            children: [
              //SizedBox(height: 12.0,),
              //BankAccountList(),
              //SizedBox(height: 12.0,),
              // CategoryList(),
              //SizedBox(height: 12.0,),
              // BudgetList(),
              // SizedBox(height: 12.0,),
              // UserInfoList(),
            ],
          ),
          // menu with all actions
          drawer: AppDrawer(user: user,),
        ),
      );
  }
}