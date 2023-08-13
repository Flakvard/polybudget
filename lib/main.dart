import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home()
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // layout widget to flesh out general layout of the app. Check scaffold class in docs.
        appBar: AppBar(
          title: const Text('PolyBudget'),
          centerTitle: true,
          backgroundColor: Colors.pink[300],
        ),
        body: Row(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          backgroundColor: Colors.pink[300],
          child: const Text('Click'),
        )
    );
  }
}

