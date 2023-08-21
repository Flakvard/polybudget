import 'package:flutter/material.dart';
import 'features/authenticate/domain/user.dart';


class UserTile extends StatelessWidget {

  final MyUser? user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(user!.name),
          subtitle: Text('${user?.email}, id: ${user?.uid}'),
        ),
      ),
    );;
  }
}
