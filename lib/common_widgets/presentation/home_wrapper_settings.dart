import 'package:flutter/material.dart';
import 'package:polybudget/features/home/presentation/settings_form.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;
import 'package:polybudget/features/home/presentation/menu.dart';
import 'package:polybudget/database.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/features/budget/domain/budget.dart';

class HomeWrapperOptions extends StatelessWidget {

  final Widget content;
  final Widget options;
  final Widget filter;
  final Widget floatingButton;

  HomeWrapperOptions({required this.content, super.key, required this.options, required this.filter, required this.floatingButton});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: options,
        );
      });
    }
    void _showFilterPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: filter,
        );
      });
    }

    return Scaffold( // layout widget to flesh out general layout of the app. Check scaffold class in docs.
      key: _scaffoldKey, // Assign the scaffold key
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        title: const Text('PolyBudget'),
        centerTitle: true,
        backgroundColor: Colors.pink[300],
        elevation: 0.0, // removes shadow
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterPanel(),

          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsPanel(),

          ),
        ],
      ),
      body: content,
        floatingActionButton: floatingButton
    );
  }
}
