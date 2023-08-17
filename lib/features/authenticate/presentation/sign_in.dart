import 'dart:math';

import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // instance of AuthService
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        elevation: 0.0,
        title: const Text('Sign in to PolyBudget'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            TextFormField(
              onChanged: (val){
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              obscureText: true,
              onChanged: (val){
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () async {
                print(email);
                print(password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
              ),
              child: Text(
                'Sign in',
                style: TextStyle(color: Colors.white),
              )
            ),
          ],
        ),
      ),
    );
  }
}
// FloatingActionButton(
// onPressed: () async {
// dynamic result = await _auth.signInAnon();
// if (result == null){
// print('error signing in null');
// }else{
// print('signed in');
// print(result.uid);
// }
// },
// child: const Text('Sign in anon'),
// ),