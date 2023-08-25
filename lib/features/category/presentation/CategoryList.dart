import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;

import 'CategoryTile.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {

    final categories = Provider.of<List<c.Category?>?>(context) ?? [];
    
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: categories?.length,
      itemBuilder: (context, index){
        return CategoryTile(category: categories![index]);
      },
    );
  }
}
