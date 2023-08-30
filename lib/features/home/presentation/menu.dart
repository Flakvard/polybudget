import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';
import '../../authenticate/presentation/user.dart';
import '../../transaction/presentation/transactionList.dart';
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
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/user');
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.balance),
            title: const Text('Budgets'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/budgets');
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Bank Accounts'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/bankaccounts');
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Categories'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/categories');
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
          // Add more ListTile widgets for additional menu items
        ],
      ),
    );
  }
}


