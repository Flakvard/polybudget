

class Budget {
  final String id;
  final String name;

  Budget({required this.id, required this.name});


  factory Budget.fromJson(Map<String, dynamic> data) {
    // ! there's a problem with this code (see below)
    final id = data['id'];
    final name = data['name'];
    return Budget(id: id, name: name);
  }


}