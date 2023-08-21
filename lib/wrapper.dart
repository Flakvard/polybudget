import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/authenticate/presentation/authenticate.dart';
import 'package:polybudget/home.dart';
import 'package:provider/provider.dart';

import 'features/authenticate/application/auth.dart';
import 'loading.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

    if (user == null) {
      return const Authenticate();
    } else {
      // Navigate to the home screen using the named route
      return const Home();
    }
  }
}


