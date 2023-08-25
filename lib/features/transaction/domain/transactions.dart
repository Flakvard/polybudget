import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:intl/intl.dart';

enum TransactionType {
  actual, expected;
}

// Transaction class data structure for holding transactions.
class Transaction {

  final String id;
  final Budget budget;
  final String text;
  final double amount;
  final Category category;
  final DateTime date;
  final bool recurring;
  final TransactionType transactionType;
  final BankAccount bankAccount;

  Transaction({
    required this.id,
    required this.text,
    required this.amount,
    required this.budget,
    required this.category,
    DateTime? date, // Allow date to be nullable
    this.recurring = false, // Provide a default value
    required this.transactionType,
    required this.bankAccount,
  }) :
        date = date ?? _getDefaultDate(); // Use today's date if not specified

  @override
  String toString() {
    return 'Transaction{'
        'id: $id, '
        'text: $text, '
        'total: $amount, '
        'budget: $budget, '
        'category: $category, '
        'date: $date, '
        'recurring: $recurring, '
        'transactionType: $transactionType, '
        'bankAccount: $bankAccount'
        '}';
  }
  static DateTime _getDefaultDate() => DateTime.now();

  String getFormatDate(){
    final newFormat = DateFormat("dd-MM-yyyy");
    String dateFormatted = newFormat.format(date);
    return dateFormatted; // 18-08-2023
  }

  // static String _getDefaultDate() {
  //   DateTime now = DateTime.now();
  //   // TODO: format date time to DD-MM-YYYY in a more neat way
  //   String formattedDate = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
  //   return formattedDate;
  // }
}
