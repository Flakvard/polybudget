// Transaction class data structure for holding transactions.
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
    // TODO: format date time to DD-MM-YYYY in a more neat way
    String formattedDate = "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}";
    return formattedDate;
  }
}
