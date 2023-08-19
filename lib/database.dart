import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/budget/domain/bankAccount.dart';
import 'features/budget/domain/budget.dart';
import 'package:polybudget/features/budget/domain/category.dart' as c;
import 'package:polybudget/features/transaction/application/transactions.dart' as t;

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference polyBudgetDB = FirebaseFirestore.instance.collection('pbUsers');

  // Now you can add these instances to Firestore as needed

  // sends data to firestore db
  Future updateUserData({required String name, required String email}) async {
    return await polyBudgetDB
        .doc(uid)
        .set({
          "User": {
            "username": name,
            "email": email,
          }
        });
  }

  // Create a new budget document for the user with the uid
  Future createBudgetDocument({required Budget budget}) async {
    return await polyBudgetDB
        .doc(uid).collection("budgets").doc(budget.id)
        .set({
      "budgets": {
        "id": budget.id,
        "name": budget.name,
        }
    });
  }
  Future createCategoryDocument({required Budget budget, required c.Category category}) async {
    return await polyBudgetDB
        .doc(uid).collection('categories').doc(category.id)
        .set({
      "categories": {
        "id": category.id,
        "name": category.name,
      }
    });
  }

  Future createBankAccountDocument({required Budget budget, required BankAccount bankAccount}) async {
    return await polyBudgetDB
        .doc(uid).collection('bankAccounts').doc(bankAccount.id)
        .set({
      "bankAccounts": {
        "id": bankAccount.id,
        "name": bankAccount.name,
        "balance": bankAccount.balance
      }
    });
  }

  Future createTransactionDocument({required t.Transaction transaction}) async {
    return await polyBudgetDB.doc(uid).collection("transactions").doc(transaction.id).set({
      "transaction": {
        "id": transaction.id,
        "text": transaction.text,
        "amount": transaction.amount,
        "date": transaction.date,
        "transactionType": transaction.transactionType.name,
        "recurring": transaction.recurring,
        "bankAccountId": transaction.bankAccount.id,
        "bankAccount": transaction.bankAccount.name,
        "categoryId": transaction.category.id,
        "category": transaction.category.name,
        "budgetId": transaction.budget.id,
        "budget": transaction.budget.name,
      }
    });

  }

  // returns a snapshot of the db
  Stream<QuerySnapshot<Object?>> get myUsers {
    return polyBudgetDB.snapshots();
  }

}

