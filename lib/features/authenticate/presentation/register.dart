import 'package:flutter/material.dart';
import '../application/auth.dart';


class Register extends StatefulWidget {

  final Function()? toggleView;
  const Register({super.key, this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // instance of AuthService
  final AuthService _auth = AuthService();

  // register
  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        elevation: 0.0,
        title: const Text('Sign up to PolyBudget'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Sign in'),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            onPressed: (){
              widget.toggleView!();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20.0,),
            TextFormField(
              onChanged: (val){
                setState(() => email = val);
              },
            ),
            const SizedBox(height: 20.0,),
            TextFormField(
              obscureText: true,
              onChanged: (val){
                setState(() => password = val);
              },
            ),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () async {
                print(email);
                print(password);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
              ),
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.white),
              )
            ),
          ],
        ),
      ),
    );
  }
}
