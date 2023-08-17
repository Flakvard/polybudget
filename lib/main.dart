// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/transaction/presentation/transactionList.dart';
import 'package:polybudget/home.dart';
import 'package:polybudget/loading.dart';
import 'package:polybudget/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:polybudget/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:polybudget/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';

import 'features/authenticate/application/auth.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        home: Wrapper(),

      // initialRoute: '/home',
      // routes: {
      //   '/': (context) => const Loading(),
      //   '/home': (context) => const Home(),
      //   '/transaction': (context) => const TransactionList(),
      //   '/user': (context) => const UserPage(),
      // },
    ),
  );
  }
}


