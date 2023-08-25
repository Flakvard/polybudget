import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/authenticate/presentation/authenticate.dart';
import 'package:polybudget/features/home/presentation/home.dart';
import 'package:polybudget/features/authenticate/presentation/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:polybudget/firebase_options.dart';
import 'package:polybudget/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:polybudget/features/authenticate/application/auth.dart';
import 'package:polybudget/common_widgets/presentation/loading.dart';
import 'features/home/presentation/UserInfoList.dart';
// import 'features/transaction/presentation/transactions.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user, // should return user uid otherwise null
      child: MaterialApp(
        initialRoute: '/wrapper',
        routes: {
          '/': (context) => const Loading(),
          '/wrapper': (context) => const Wrapper(),
          '/authenticate': (context) => const Authenticate(),
          '/home': (context) => Home(),
          //'/transaction': (context) => Transactions(),
          '/user': (context) => const UserPage(),
          '/userinfo': (context) => const UserInfoList(),
        },
      ),
    );
  }
}


