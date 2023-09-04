import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';
import '../../authenticate/domain/user.dart';

class AppDrawer extends StatelessWidget {
  MyUser? user;
  AppDrawer({super.key, this.user});

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
              Navigator.pushReplacementNamed(context, '/home'); // Close the drawer
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
              Navigator.pushNamed(context, '/budgets', arguments: {
                'user': user,
              });
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text('Bank Accounts'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/bankaccounts', arguments: {
                'user': user,
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.category_outlined),
            title: const Text('Categories'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/categories', arguments: {
                'user': user,
              });
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Transaction'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.pushNamed(context, '/transactionList');
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


