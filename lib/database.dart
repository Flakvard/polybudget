import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference polyBudgetDB = FirebaseFirestore.instance.collection('pbUsers');

  Future updateUserData(String name) async {
    return await polyBudgetDB
        .doc(uid)
        .set({
          'name': name,
        });
  }
  // late String text;
  // late double total;
  // late String category;
  // late String date;
  // late bool recurring;
  // late String transactionType;
  // late String bankAccount;

}