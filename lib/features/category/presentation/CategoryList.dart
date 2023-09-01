import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/category/presentation/category_settings_form.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'CategoryTile.dart';


class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final MyUser? user = args['user'];


    // final categories = Provider.of<List<c.Category?>?>(context) ?? [];
    
    return StreamProvider<List<c.Category?>?>.value(
      value: DatabaseService(uid: user?.uid).userCategory,
      initialData: const [],
      child: Consumer<List<c.Category?>?>(
        builder: (context, categories, child){
        return HomeWrapper(
          content: Column(
            children: [
             ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: categories?.length,
                itemBuilder: (context, index){
                  return CategoryTile(category: categories![index], user: user!,);
                },
              ),
            ],
          ), options: const CategorySettingsForm(),
        );
      }),
    );
  }
}
