import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polybudget/features/authenticate/domain/user.dart';
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'features/budget/domain/budget.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;
import 'package:polybudget/features/transaction/domain/transactions.dart' as t;

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference polyBudgetDB = FirebaseFirestore.instance.collection('pbUsers');

  // Now you can add these instances to Firestore as needed


  // returns a snapshot of the db
  // Get stream from firestore
  Stream<List<MyUser?>?> get myUsers {
    return polyBudgetDB.snapshots()
        .map(_userListFromSnapshot);
  }

  // returns a list of all the user inside collection db
  List<MyUser?>? _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return MyUser(
        uid: doc.get('id') ?? '',
        name: doc.get('name') ?? '',
        email: doc.get('email') ?? '',
      );
    }).toList();
  }

  // get user doc stream
  Stream<MyUser?> get userData {
    return polyBudgetDB.
    doc(uid).
    snapshots().
    map(_userDataFromSnapshot);
  }

  // get user stream and map to user class
  MyUser? _userDataFromSnapshot(DocumentSnapshot snapshot){
    return MyUser(
        uid: uid.toString(),
        name: snapshot.get('name') ?? '',
        email: snapshot.get('email') ?? '',
    );
  }

  Stream<List<Budget?>?> get userBudget {
    return polyBudgetDB
        .doc(uid)
        .collection("budgets")
        .snapshots()
        .map(_budgetListFromSnapshot);
  }

  // returns a list of all the user inside collection db
  List<Budget?>? _budgetListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Budget(
        id: doc.get('id') ?? '',
        name: doc.get('name') ?? '',
      );
    }).toList();
  }

  Stream<List<c.Category?>?> get userCategory  {
    return polyBudgetDB
        .doc(uid)
        .collection("categories")
        .snapshots()
        .map(_categoriesListFromSnapshot);
  }

  // returns a list of all the user inside collection db
  List<c.Category?>? _categoriesListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return c.Category(
        id: doc.get('id') ?? '',
        name: doc.get('name') ?? '',
      );
    }).toList();
  }

  Stream<List<BankAccount?>?> get userBankAccount   {
    return polyBudgetDB
        .doc(uid)
        .collection("bankAccounts")
        .snapshots()
        .map(_bankAccountsListFromSnapshot);
  }

  // returns a list of all the user inside collection db
  List<BankAccount>? _bankAccountsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return BankAccount(
        id: doc.get('id') ?? '',
        name: doc.get('name') ?? '',
      );
    }).toList();
  }



  Stream<List<t.Transaction?>?> userTransactionsByAccount({required String? bankAccountId, required String year, required String month})  {
    return polyBudgetDB
        .doc(uid)
        .collection("bankAccounts")
        .doc(bankAccountId)
        .collection("Year")
        .doc(year)
        .collection("Month")
        .doc(month)
        .collection("transactions")
        .snapshots()
        .map(_transactionsListFromSnapshot);
  }

  // returns a list of all the user inside collection db
  List<t.Transaction>? _transactionsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => t.Transaction.fromFirestore(doc)).toList();
  }

  Stream<List<t.Transaction?>?> allUserTransactions({required String year, required String month})  {
    return polyBudgetDB
        .doc(uid)
        .collection("bankAccounts")
        .snapshots()
        .asyncMap((bankAccountSnapshot) async {
      final List<t.Transaction?> transactions = [];

      for (final bankAccountDoc in bankAccountSnapshot.docs) {
        final bankAccountId = bankAccountDoc.id;
        final transactionQuery = await polyBudgetDB
            .doc(uid)
            .collection("bankAccounts")
            .doc(bankAccountId)
            .collection("Year")
            .doc(year)
            .collection("Month")
            .doc(month)
            .collection("transactions")
            .get();

        transactions.addAll(_transactionsListFromSnapshot(transactionQuery) as Iterable<t.Transaction?>);
      }
      for (int i = 0; i < transactions.length; i++) {
        t.Transaction? transaction = transactions[i];
        print(transaction.toString());
      }

      return transactions;
    });
  }

  // sends data to firestore db to update
  Future updateUserData({required String? name, required String? email}) async {
    return await polyBudgetDB
        .doc(uid)
        .set({
          "id": uid,
          "name": name,
          "email": email,
        });
  }

  // Create a new budget document for the user with the uid
  Future createBudgetDocument({required Budget budget}) async {
    return await polyBudgetDB
        .doc(uid).collection("budgets").doc(budget.id)
        .set({
        "id": budget.id,
        "name": budget.name,
    });
  }
  Future createCategoryDocument({required c.Category category}) async {
    return await polyBudgetDB
        .doc(uid).collection('categories').doc(category.id)
        .set({
        "id": category.id,
        "name": category.name,
    });
  }

  Future createBankAccountDocument({required BankAccount bankAccount}) async {
    return await polyBudgetDB
        .doc(uid).collection('bankAccounts').doc(bankAccount.id)
        .set({
        "id": bankAccount.id,
        "name": bankAccount.name,
        "balance": bankAccount.balance
    });
  }

  Future createTransactionDocument({required t.Transaction transaction}) async {
    return await polyBudgetDB
        .doc(uid)
        .collection("bankAccounts")
        .doc(transaction.bankAccount.id)
        .collection("Year")
        .doc(transaction.date.year.toString())
        .collection("Month")
        .doc(transaction.date.month.toString())
        .collection("transactions")
        .doc(transaction.id).set({
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
    });

  }

}

