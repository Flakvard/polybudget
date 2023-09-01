import 'package:flutter/material.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;
import 'package:polybudget/features/authenticate/domain/user.dart';

import '../../../common_widgets/presentation/constants.dart';

class CategoryUpdateSettForm extends StatefulWidget {

  final c.Category? category;
  final MyUser? user;

  const CategoryUpdateSettForm({super.key, required this.category, required this.user});

  @override
  State<CategoryUpdateSettForm> createState() => _CategoryUpdateSettFormState();
}

class _CategoryUpdateSettFormState extends State<CategoryUpdateSettForm> {
  @override
  Widget build(BuildContext context) {

    // form values
    late String? _currentName;

    final _formkey = GlobalKey<FormState>();

    void close(){
      Navigator.pop(context);
    }

    return Form(
      key: _formkey,

      child: Column(
        children: [
          const Text(
            'Update category information',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0,),
          TextFormField(
              initialValue: widget.category?.name,
              decoration: textInputDecoration, // constant.dart
              validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
              onChanged: (val) => _currentName = val),

          const SizedBox(height: 20.0,),

          // update button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink[400],
            ),
            onPressed: () async {
              if(_formkey.currentState!.validate()){
                widget.user!.updateCategory(
                    categoryId: widget.category!.id,
                    newName: _currentName ?? widget.category!.name);

                close(); // Navigate.pop(context)
              }
            },
            child: const Text('Update Category', style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }
}
