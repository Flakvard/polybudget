import 'package:flutter/material.dart';
import 'package:polybudget/common_widgets/presentation/constants.dart';
import 'package:polybudget/common_widgets/presentation/loading.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4']; // dropdown values

  // form values
  late String _currentName;
  late int _currentEmail = 100; // slider
  late String _currentString = '0'; // dropdown

  @override
  Widget build(BuildContext context) {


    // access to the current user logged in
    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

    return StreamBuilder( // default steam provider
      stream: DatabaseService(uid: user?.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          MyUser? userData = snapshot.data;
          return Form(
            key: _formkey,

            child: Column(
              children: [
                const Text(
                  'Update your settings.',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: textInputDecoration, // constant.dart
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),
                const SizedBox(height: 20.0,),
                // dropdown
                DropdownButtonFormField<String>(
                  decoration: textInputDecoration,
                  value: _currentString ?? '0', // fallback value / default value
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars')
                    );
                  }).toList(),
                  onChanged: (val) => setState(()
                  => _currentString = val!),
                ),
                // slider
                Slider(
                  activeColor: Colors.brown[_currentEmail ?? 100],
                  inactiveColor: Colors.brown[_currentEmail ?? 100],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  value: (_currentEmail ?? 100).toDouble(),
                  onChanged: (val) => setState(() => _currentEmail = val.round()),
                ),

                // update button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  onPressed: () async {
                    print(_currentName);
                    print(_currentEmail);
                    print(_currentString);
                  }, child: const Text('Update', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          );
        }else{
          return const Loading();
        }
      }
    );
  }
}
