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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        elevation: 0.0,
        title: Text('Sign in to PolyBudget'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: FloatingActionButton(
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null){
              print('error siging in null');
            }else{
              print('signed in');
              print(result);
            }
          },
          child: Text('Sign in anon'),
        ),
      ),
    );
  }
}
