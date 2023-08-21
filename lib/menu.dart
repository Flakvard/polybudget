import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';
import 'features/authenticate/presentation/user.dart';
import 'features/transaction/presentation/transactionList.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.pink,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Handle tapping on Home menu item
              Navigator.pop(context); // Close the drawer
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('Sign Out'),
            onTap: () async {
              await _auth.signOut();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/user');
              //Navigator.push(context,MaterialPageRoute(builder: (context) => const UserPage()),);
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_card),
            title: const Text('Transactions'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/transaction');
              // Navigator.push(context,MaterialPageRoute(builder: (context) => const TransactionList()),);
              // You can add your navigation logic here
            },
          ),
          // Add more ListTile widgets for additional menu items
        ],
      ),
    );
  }
}


