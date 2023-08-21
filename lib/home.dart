import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/menu.dart';
import 'package:polybudget/database.dart';
import 'package:provider/provider.dart';

import 'UserInfoList.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<MyUser?>?>.value(
      // returns the collection of user db from firestore
      value: DatabaseService()?.myUsers,
      initialData: const [],
      child: Scaffold( // layout widget to flesh out general layout of the app. Check scaffold class in docs.
        key: _scaffoldKey, // Assign the scaffold key
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: const Text('PolyBudget'),
          // adding hamburger menu icon
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Open the drawer when the icon is clicked
              _scaffoldKey.currentState?.openDrawer(); // Use ?. to handle null currentState
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.pink[300],
          elevation: 0.0, // removes shadow
        ),
        body: UserInfoList(),
        drawer: AppDrawer(),
      ),
    );
  }
}

//
// SafeArea(
// child: Column(
// children: [
// const Center(
// child: UserInfoList(),
// ),
// const SizedBox(height: 6,),
// const SizedBox(height: 6,),
// Center(
// child: ElevatedButton(
// onPressed: () {
// // Navigate to User Page when the button is clicked
// Navigator.pushNamed(context, '/transaction');
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.pink[300],
// ),
// child: const Text('Transaction Page'),
// ),
// ),
// const SizedBox(height: 6,),
// Center(
// child: ElevatedButton(
// onPressed: () {
// // Navigate to User Page when the button is clicked
// Navigator.pushNamed(context, '/Authenticate');
// },
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.pink[300],
// ),
// child: const Text('SignIn'),
// ),
// ),
// ],
// ),
// )