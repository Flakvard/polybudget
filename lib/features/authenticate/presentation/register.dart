import 'package:flutter/material.dart';
import '../application/auth.dart';
import 'package:polybudget/common_widgets/presentation/constants.dart';


class Register extends StatefulWidget {

  final Function()? toggleView;
  const Register({super.key, this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  // instance of AuthService
  final AuthService _auth = AuthService();
  // identify form and validate the data
  final _formKey = GlobalKey<FormState>();

  // register
  String email = '';
  String password = '';
  String error = '';


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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              const SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              const SizedBox(height: 20.0,),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null ){
                      setState(() => error = 'Please supply a valid email');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[300],
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                )
              ),
              const SizedBox(height: 12.0,),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
