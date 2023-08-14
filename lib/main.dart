import 'package:flutter/material.dart';
// import 'home.dart';

void main() {
  runApp(const MaterialApp(
    home: TransactionList()
  ));
}

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  // late List<Transaction> transaction;
  late List<String> transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: const Text('PolyBudget'),
        centerTitle: true,
        elevation: 0.0, // removes shadow
      ),
      backgroundColor: Colors.grey,
    );
  }
}

class Transaction {
  late String text;
  late double total;
  late String category;
  late String date;
  late bool recurring;
  late String transactionType;
  late String bankAccount;

  Transaction({
    required this.text,
    required this.total,
    required this.category,
    String? date, // Allow date to be nullable
    this.recurring = false, // Provide a default value
    required this.transactionType,
    required this.bankAccount,
  }) : date = date ?? _getDefaultDate(); // Use today's date if not specified

  @override
  String toString() {
    return 'Transaction{'
        'text: $text, '
        'total: $total, '
        'category: $category, '
        'date: $date, '
        'recurring: $recurring, '
        'transactionType: $transactionType, '
        'bankAccount: $bankAccount'
        '}';
  }
  static String _getDefaultDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    return formattedDate;
  }
}


