import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference polyBudgetDB = FirebaseFirestore.instance.collection('pbUsers');

  Future updateUserData(String name, String email, String budgetName, String categories,) async {
    return await polyBudgetDB
        .doc(uid)
        .set({
            "username": name,
            "email": email,
            "budgets": {
              "budget_id": {
                "name": budgetName,
                "categories": {
                  "category_id_1": {
                    "name": categories,
                  }
                },
                "bankAccounts": {
                  "account_id_1": {
                    "name": "Savings Account",
                    "balance": 5000.0
                  },
                  "account_id_2": {
                    "name": "Checking Account",
                    "balance": 1500.0
                  }
                },
                "transactions": {
                  "transaction_id_1": {
                    "type": "income",
                    "amount": 100.0,
                    "category": "category_id_1",
                    "date": "2023-08-15"
                  },
                  "transaction_id_2": {
                    "type": "expense",
                    "amount": 50.0,
                    "category": "category_id_2",
                    "date": "2023-08-17"
                  }
                }
              }
            }
        });
  }
  // returns a snapshot of the db
  Stream<QuerySnapshot<Object?>> get myUsers {
    return polyBudgetDB.snapshots();
  }


  // late String text;
  // late double total;
  // late String category;
  // late String date;
  // late bool recurring;
  // late String transactionType;
  // late String bankAccount;

}