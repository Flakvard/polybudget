import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/transaction/domain/transactions.dart' as t;
import 'package:polybudget/features/authenticate/domain/user.dart';

import '../../../common_widgets/presentation/constants.dart';
import '../../../common_widgets/presentation/loading.dart';


class TransactionFilterForm extends StatefulWidget {
  final Function(String, String) onFilterChanged;
  final MyUser user;
  final String year;
  final String month;
  const TransactionFilterForm({super.key, required this.onFilterChanged, required this.user, required this.year, required this.month});

  @override
  _TransactionFilterFormState createState() => _TransactionFilterFormState();
}

class _TransactionFilterFormState extends State<TransactionFilterForm> {
  late String selectedYear = widget.year;
  late String selectedMonth = widget.month;
  String selectedBankAccountId = ''; // Initialize with an empty string

  final _formkey = GlobalKey<FormState>();
  // Add other filter criteria such as day if needed
  final List<String> years = ['2021','2022','2023','2024','2025']; // dropdown values
  final List<String> months = ['1','2','3','4','5','6','7','8','9','10','11','12']; // dropdown values

  @override
  Widget build(BuildContext context) {

    void close(){
      Navigator.pop(context);
    }

    return StreamBuilder(
        stream: DatabaseService(uid: widget.user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // access to the current user data
            // MyUser? userData = snapshot.data;
            return Form(
              key: _formkey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    value: selectedYear,
                    items: years.map((year) {
                      return DropdownMenuItem(
                          value: year,
                          child: Text('Year: $year')
                      );
                    }).toList(),
                    validator: (newValue) => newValue!.isEmpty ? 'Please enter a year' : null,
                    onChanged: (newValue) => setState(() => selectedYear = newValue!),
                  ),
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    value: selectedMonth,
                    items: months.map((month) {
                      return DropdownMenuItem(
                          value: month,
                          child: Text('Month: $month')
                      );
                    }).toList(),
                    validator: (newValue) => newValue!.isEmpty ? 'Please enter a month' : null,
                    onChanged: (newValue) => setState(() => selectedMonth = newValue!),
                  ),
                  // Add other filter criteria widgets here
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                    ),
                    onPressed: () async {
                      print('outside validate function');
                      if(_formkey.currentState!.validate()){
                        print('inside validate function');
                        widget.onFilterChanged(selectedYear, selectedMonth); // Call the callback
                        close(); // Navigate.pop(context)
                      }
                    },
                    child: const Text('Update', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            );
          }else{
            return const Loading();
          }
        }
    );
  }
}

