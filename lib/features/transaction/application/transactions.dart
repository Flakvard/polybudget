import 'package:polybudget/features/budget/domain/bankAccount.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/budget/domain/category.dart';

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
  final String date;
  final bool recurring;
  final TransactionType transactionType;
  final BankAccount bankAccount;

  Transaction({
    required this.id,
    required this.text,
    required this.amount,
    required this.budget,
    required this.category,
    String? date, // Allow date to be nullable
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
  static String _getDefaultDate() {
    DateTime now = DateTime.now();
    // TODO: format date time to DD-MM-YYYY in a more neat way
    String formattedDate = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    return formattedDate;
  }
}
