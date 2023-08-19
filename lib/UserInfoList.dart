import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    final myUser = Provider.of<QuerySnapshot?>(context);


    if (myUser == null) {
      return const CircularProgressIndicator(); // Return a loading indicator or handle the null case
    }

    //print(myUser?.docs);
    for(var doc in myUser!.docs){
      final data = doc.data() as Map<String, dynamic>; // Invoke data() to get the actual data
      print(data);
    }

    return Container();
  }
}
