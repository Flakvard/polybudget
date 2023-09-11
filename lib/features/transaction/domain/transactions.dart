import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/category/domain/category.dart';
import 'package:intl/intl.dart';

enum TransactionType {
  actual, expected;
}

extension TransactionTypeHelper on TransactionType{
  TransactionType getTypeByString(String type) {
    if (type == "expected") return TransactionType.expected;
    return TransactionType.actual;
  }
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




  factory Transaction.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    double amount = (data?['amount']?? 0.0).toDouble();
    BankAccount bankAccount = BankAccount(id: data?['bankAccountId'], name: data?['bankAccount']);
    Budget budget = Budget(id: data?['budgetId'], name: data?['budget']);
    Category category = Category(id: data?['categoryId'], name: data?['category']);
    // final dateStringFromFirebase = data?['date'];
    // DateTime date = DateFormat("MMMM d, yyyy 'at' h:mm:ss a 'UTC'Z").parseLoose(dateStringFromFirebase);
    // Convert Firestore Timestamp to DateTime
    Timestamp timestamp = data?['date'];
    DateTime date = timestamp.toDate();
    final id = doc.id;
    final recurring = data?['recurring'] ?? false;
    final text = (data?['name'] ?? '');
    TransactionType transactionType = TransactionType.expected;
    transactionType.getTypeByString(data?['transactionType']);

    return Transaction(
        id: id,
        budget: budget,
        text: text,
        amount: amount,
        category: category,
        date: date,
        recurring: recurring,
        transactionType: transactionType,
        bankAccount: bankAccount
    );
  }
}
