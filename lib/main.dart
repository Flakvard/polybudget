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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('hello'),
                Text('world'),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.cyan,
              child: const Text('one'),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.pink,
              child: const Text('two'),
            ),
            Container(
              padding: EdgeInsets.all(40.0),
              color: Colors.amber,
              child: const Text('three'),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {  },
          backgroundColor: Colors.pink[300],
          child: const Text('Click'),
        )
    );
  }
}

// working with rows
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: <Widget>[
// const Text('Hello world'),
// TextButton(
// onPressed: (){print('hey console');},
// style: TextButton.styleFrom(
// backgroundColor: Colors.pink[300],
// ),
// child: Text('Click'),
// ),
// Container(
// color: Colors.cyan,
// padding: EdgeInsets.all(30.0),
// child: Text('Inside container'),
// ),
// ],
// ),

// cannot use margins og color inside padding, only the text itself
// Padding(
// padding: EdgeInsets.all(90.0),
// child: Text('hello'),
// ),

// patting and margins inside containers
//Container(
//color: Colors.grey[400],
//padding: EdgeInsets.all(20.0),
//padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
//padding: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0),
//margin: EdgeInsets.all(20.0),
//margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
//margin: EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0),
// child: Text('hello'),
//),

// Buttons, icon, images ect.
// Center(
// child: IconButton(
//   onPressed: () {
//     print('hello world');
//   },
//   icon: Icon(Icons.alternate_email),
//   color: Colors.pink[300],
// ),
// child: ElevatedButton.icon(
//   onPressed: (){},
//   icon: const Icon(
//   Icons.mail,
// ),
//   label: Text('Mail me'),
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.pink[300],
//   ),
// ),
// child: ElevatedButton( // raisedButton
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.pink[300],
//   ),
//   onPressed: () {
//     print('you clicked me');
//   },
//   child: Text('Click me'),
// ),
// child: Icon(
//   Icons.airport_shuttle,
//   color: Colors.lightBlue,
//   size: 50.0,
// ),
// child: Image(
//   image: AssetImage('assets/pinkPig.jpg'),
// ),
// child: Text(
//     'Hello my dudes',
//     style: TextStyle(
//         fontSize: 20.0,
//         fontWeight: FontWeight.bold,
//         color: Colors.grey,
//         fontFamily: 'IndieFlower'
//     )
// ),
// )

