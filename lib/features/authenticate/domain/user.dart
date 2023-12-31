import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/category/domain/category.dart' as c;
import 'package:polybudget/features/transaction/domain/transactions.dart' as t;
import 'package:polybudget/features/bankaccount/domain/bankAccount.dart';
import 'package:polybudget/database.dart';

import '../application/auth.dart';

class MyUser{
  final String uid;
  final String name; // add later and is nullable
  final String email; // add later and is nullable
  List<Budget> budgets; // add later and is nullable
  List<c.Category> categories; // add later and is nullable
  List<BankAccount> bankAccounts; // add later and is nullable
  List<t.Transaction> transactions; // add later and is nullable


  MyUser({
    required this.uid,
    String? name,
    String? email,
    List<Budget>? budget,
    List<c.Category>? category,
    List<BankAccount>? bankAccount,
    List<t.Transaction>? transaction
  }) : name = name ?? '', email = email ?? '', budgets = budget ?? [], categories = category ?? [], bankAccounts = bankAccount ?? [], transactions = transaction ?? [];



  Future<void> setupUser() async {
    try {
      // Create and return a new budget class for the user add it to the database
      final Budget budget = await createBudget(budgetName: 'Personal Budget');

      // Create and return a new category class for the user add it to the database
      final c.Category category = await createCategory(categoryName: 'Groceries');

      // Create and return a new BankAccount class for the user add it to the database
      final BankAccount bankAccount = await createBankAccount(bankAccountName: 'Groceries account');

      // Create and return a new Transaction class for the user add it to the database
      final t.Transaction transaction = await createTransaction(
          transactionName: "food",
          date: "2023-08-18",
          amount: 123.0,
          budget: budget,
          bankAccount: bankAccount,
          category: category,
          recurring: false,
          transactionType: t.TransactionType.actual,
      );


      // You can add more categories and transactions here

      // Update the user's budgets and categories lists
      // final newTransaction = t.Transaction(id: 'transaction_id',budget: newBudget, transactionType: 'Expense', amount: 100.0, category: newCategory, date: '15-08-2023');

      List<Budget>.from(budgets).add(budget);
      List<c.Category>.from(categories).add(category);
      List<BankAccount>.from(bankAccounts).add(bankAccount);
      List<t.Transaction>.from(transactions).add(transaction );

      // Update the user's data in Firestore
      // final db = DatabaseService(uid: uid);
      // await db.updateUserData(name, email, updatedBudgets, updatedCategories, updatedTransactions, updatedBankAccounts);

    } catch (e) {
      print('Caught error: $e');
      // text = "Could not setup the user data";
    }
  }

  // Other methods...

  // Create a new budget document and return its ID
  Future<Budget> createBudget({required String budgetName}) async {
    // create a new id in firestore for the budget name
    final budgetId = FirebaseFirestore.instance.collection('pbUsers').doc(uid).collection('budgets').doc().id;
    // use the id from firestore to instantiate a unique budget
    final budget = Budget(id: budgetId, name: budgetName);

    // create an instance of the database from the user ID
    final db = DatabaseService(uid: uid);
    // use the created budget to assign it to the user ID document in firestore
    await db.createBudgetDocument(budget: budget);

    return budget;
  }

  // Create a new category and transaction for a budget
  Future<t.Transaction> createTransaction({
    required String transactionName,
    required double amount,
    required Budget budget,
    required c.Category category,
    required BankAccount bankAccount,
    required String date,
    required bool recurring,
    required t.TransactionType transactionType
    })
  async {
    // Parse string input YY-MM-DD into a DateTime Object
    final DateTime dateFormatted = DateTime.parse(date);
    // create a new id in firestore for the bankAccount name under budget
    final String transactionId = FirebaseFirestore.instance.collection('pbUsers').doc(uid).collection("transactions").doc().id;

    // use the id from firestore to instantiate a unique category
    final t.Transaction transaction = t.Transaction(
      id: transactionId,
      text: transactionName,
      date: dateFormatted,
      amount: amount,
      budget: budget,
      bankAccount: bankAccount,
      category: category,
      recurring: recurring,
      transactionType: transactionType,
    );

    // create an instance of the database from the user ID inside this class
    final db = DatabaseService(uid: uid);
    // use the created budget to assign it to the user ID document in firestore
    if(transaction.transactionType.name == "actual") await db.createTransactionActualDocument(transaction: transaction);
    if(transaction.transactionType.name == "expected") await db.createTransactionExpectedDocument(transaction: transaction);

    return transaction;
  }

  // add bank accounts
  // create a bankAccount class and add it to the firestore document collection
  Future<BankAccount> createBankAccount({required String bankAccountName}) async {
    // create a new id in firestore for the bankAccount name under budget
    final bankAccountId = FirebaseFirestore.instance.collection('pbUsers').doc(uid).collection('bankAccounts').doc().id;

    // use the id from firestore to instantiate a unique category
    final BankAccount bankAccount = BankAccount(id: bankAccountId, name: bankAccountName, balance: 0);

    // create an instance of the database from the user ID inside this class
    final db = DatabaseService(uid: uid);
    // use the created budget to assign it to the user ID document in firestore
    await db.createBankAccountDocument(bankAccount: bankAccount);

    return bankAccount;
  }

  // delete bank accounts
  Future<void> deleteBankAccount({required String bankId}) async {
    try {
      // Reference to the main bank account document
      final bankAccountRef = FirebaseFirestore.instance
          .collection('pbUsers')
          .doc(uid)
          .collection('bankAccounts')
          .doc(bankId);

      // Get a reference to the subcollection within the bank account
      final subcollectionRef = bankAccountRef.collection('Year'); // Replace 'transactions' with the name of your subcollection

      // Get all documents in the subcollection
      final subcollectionSnapshot = await subcollectionRef.get();

      // Delete all documents in the subcollection
      for (final subDoc in subcollectionSnapshot.docs) {
        await subDoc.reference.delete();
      }

      // Delete the main bank account document
      await bankAccountRef.delete();
    } catch (e) {
      print("Error deleting bank account: $e");
    }
  }

// update bank accounts
  Future<void> updateBankAccount({required String bankId, required String newName}) async {
    try {
      // Reference to the bank account document
      final bankAccountRef = FirebaseFirestore.instance
          .collection('pbUsers')
          .doc(uid)
          .collection('bankAccounts')
          .doc(bankId);

      // Update the bank account's name field
      await bankAccountRef.update({'name': newName});
    } catch (e) {
      print("Error updating bank account: $e");
    }
  }

  // add budgets

  // add categories
  Future<c.Category> createCategory({required String categoryName}) async {
    // create a new id in firestore for the category name under budget
    final categoryId = FirebaseFirestore.instance.collection('pbUsers').doc(uid).collection('categories').doc().id;

    // use the id from firestore to instantiate a unique category
    final c.Category category = c.Category(id: categoryId, name: categoryName);

    // create an instance of the database from the user ID inside this class
    final db = DatabaseService(uid: uid);
    // use the created budget to assign it to the user ID document in firestore
    await db.createCategoryDocument(category: category);

    return category;
  }

// delete categories
  Future<void> deleteCategory({required String categoryId}) async {
    try {
      // Reference to the main bank account document
      final bankAccountRef = FirebaseFirestore.instance
          .collection('pbUsers')
          .doc(uid)
          .collection('categories')
          .doc(categoryId);

      // TODO: Implement later:
      // Get a reference to the subcollection within the bank account
      // final subcollectionRef = bankAccountRef.collection('Year'); // Replace 'transactions' with the name of your subcollection

      // TODO: Implement later:
      // Get all documents in the subcollection
      // final subcollectionSnapshot = await subcollectionRef.get();

      // TODO: Implement later:
      // Delete all documents in the subcollection
      // for (final subDoc in subcollectionSnapshot.docs) {
      //   await subDoc.reference.delete();
      // }

      // Delete the main bank account document
      await bankAccountRef.delete();
    } catch (e) {
      print("Error deleting category: $e");
    }
  }


// update categories
  Future<void> updateCategory({required String categoryId, required String newName}) async {
    try {
      // Reference to the bank account document
      final categoryRef = FirebaseFirestore.instance
          .collection('pbUsers')
          .doc(uid)
          .collection('categories')
          .doc(categoryId);

      // Update the bank account's name field
      await categoryRef.update({'name': newName});
    } catch (e) {
      print("Error updating category: $e");
    }
  }

// delete budgets
  Future<void> deleteBudget({required String budgetId}) async {
    try {
      // Reference to the bank account document
      final budgetRef = FirebaseFirestore.instance
          .collection('pbUsers')
          .doc(uid)
          .collection('budgets')
          .doc(budgetId);

      // Update the bank account's name field
      await budgetRef.delete();
    } catch (e) {
      print("Error deleting budget: $e");
    }
  }

  // update budgets
  Future<void> updateBudget({required String budgetId, required String newName}) async {
    try {
      // Reference to the bank account document
      final budgetRef = FirebaseFirestore.instance
          .collection('pbUsers')
          .doc(uid)
          .collection('budgets')
          .doc(budgetId);

      // Update the bank account's name field
      await budgetRef.update({'name': newName});
    } catch (e) {
      print("Error updating budget: $e");
    }
  }

}
