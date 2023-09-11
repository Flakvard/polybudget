

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});



  @override
  bool operator ==(dynamic other) =>
      other != null && other is Category && id == other.id;

  @override
  int get hashCode => super.hashCode;
}