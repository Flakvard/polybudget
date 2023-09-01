
class BankAccount {
  final String id;
  final String name;
  double? balance;

  BankAccount({
    required this.id,
    required this.name,
    this.balance,
  });

}