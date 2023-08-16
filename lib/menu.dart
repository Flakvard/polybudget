import 'package:flutter/material.dart';
import 'user.dart';
import 'transactionList.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const User()),
              );
              // You can add your navigation logic here
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_card),
            title: const Text('Transactions'),
            onTap: () {
              // Handle tapping on Profile menu item
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TransactionList()),
              );
              // You can add your navigation logic here
            },
          ),
          // Add more ListTile widgets for additional menu items
        ],
      ),
    );
  }
}


