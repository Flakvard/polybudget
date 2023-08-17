import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/authenticate/presentation/authenticate.dart';
import 'package:polybudget/home.dart';
import 'package:provider/provider.dart';

import 'features/authenticate/application/auth.dart';
import 'loading.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context); // gets the state of the user (logged in or not)

    // return either home or auth widget
    if(user == null){
      return const Authenticate();
    }else {
      return Home();
    }
  }
}

