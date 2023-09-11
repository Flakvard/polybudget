import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/home/presentation/user_tile.dart';
import 'package:provider/provider.dart';


class UserInfoList extends StatefulWidget {
  const UserInfoList({super.key});

  @override
  State<UserInfoList> createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {

  @override
  Widget build(BuildContext context) {

    // Accessing data from database.dart
    final myUser = Provider.of<List<MyUser?>?>(context) ?? [];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: myUser.length,
      itemBuilder: (context, index){
        return UserTile(user: myUser[index]);
      },
    );

  }
}
