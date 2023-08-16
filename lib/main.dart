// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:polybudget/transactionList.dart';
import 'package:polybudget/home.dart';
import 'package:polybudget/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => const Loading(),
    '/home': (context) => const Home(),
    '/transaction': (context) => const TransactionList(),
  },
));

