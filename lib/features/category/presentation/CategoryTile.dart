import 'package:flutter/material.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;

class CategoryTile extends StatelessWidget {

  final c.Category? category;
  const  CategoryTile({super.key, required this.category});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(category!.name),
          subtitle: Text('id: ${category?.id}'),
        ),
      ),
    );
  }
}
