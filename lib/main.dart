import 'package:flutter/material.dart';
import 'user.dart';

void main() {
  runApp(const MaterialApp(
    home: Home()
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // layout widget to flesh out general layout of the app. Check scaffold class in docs.
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: const Text('PolyBudget'),
          centerTitle: true,
          backgroundColor: Colors.pink[300],
          elevation: 0.0, // removes shadow
        ),
        body: Center(
            child: ElevatedButton(
             onPressed: () {
               // Navigate to User Page when the button is clicked
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => User()),
               );
             },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[300],
              ),
              child: const Text('User Page'),
           ),
        ),
    );
  }
}

