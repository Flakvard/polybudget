import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/transaction/presentation/transactionList.dart';
import 'package:polybudget/home.dart';
import 'package:polybudget/features/authenticate/presentation/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:polybudget/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:polybudget/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';
import 'package:polybudget/common_widgets/presentation/loading.dart';

import 'features/authenticate/application/auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        home: Wrapper(),

      // TODO: https://docs.flutter.dev/cookbook/navigation/named-routes
      // initialRoute: '/wrapper',
      // routes: {
      //   '/': (context) => const Loading(),
      //   '/home': (context) => const Home(),
      //   '/wrapper': (context) => const Wrapper(),
      //   '/transaction': (context) => const TransactionList(),
      //   '/user': (context) => const UserPage(),
      // },
    ),
  );
  }
}


