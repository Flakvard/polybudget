
class BankAccount {
  final String id;
  final String name;
  double? balance;

  BankAccount({
    required this.id,
    required this.name,
    this.balance,
  });

  @override
  bool operator ==(dynamic other) =>
      other != null && other is BankAccount && id == other.id;

  @override
  int get hashCode => super.hashCode;

}