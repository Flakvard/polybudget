// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:polybudget/features/transaction/presentation/transactionList.dart';
import 'package:polybudget/home.dart';
import 'package:polybudget/loading.dart';
import 'package:polybudget/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:polybudget/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


Future<void> main() async {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/': (context) => const Loading(),
      '/home': (context) => const Home(),
      '/transaction': (context) => const TransactionList(),
      '/user': (context) => const UserPage(),
    },
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

