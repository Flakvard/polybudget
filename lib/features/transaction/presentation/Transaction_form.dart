import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:polybudget/common_widgets/presentation/home_wrapper_add.dart';
import 'package:polybudget/database.dart';
import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:polybudget/features/transaction/presentation/transaction_options_by_bank_account.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/presentation/constants.dart';
import '../../authenticate/domain/user.dart';
import '../../bankaccount/domain/bankAccount.dart';
import '../../category/domain/category.dart' as c;
import '../domain/transactions.dart';


class TransactionForm extends StatefulWidget {

  final BankAccount? bank;
  final c.Category? category;
  final Budget? budget;
  final Function? onChanged;

  const TransactionForm({super.key, required this.bank, required this.category, required this.budget, this.onChanged});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formkey = GlobalKey<FormState>();

  String _currentName = 'New transaction';
  String? amountValue;
  DateTime firstDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  DateTime lastDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+14);
  // form values
  Function? onChanged;
  TextEditingController dateInput = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final bool allowDecimal = true;

  String _getRegexString() =>
      allowDecimal ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';

  bool isRecurring = false; // Default value for recurring

  final BankAccount? noBankAccount = BankAccount(id: '', name: 'No Bank Account');
  final c.Category? noCategory = c.Category(id: '', name: 'No Category');
  final Budget? noBudget = Budget(id: '', name: 'No Budget');
  BankAccount? selectedBankAccount; // Initialize with an empty string

  c.Category? selectedCategory; // Initialize with an empty string
  Budget? selectedBudget;// Initialize with an empty string
  late TransactionType selectedTransactionType; // Default value for TransactionType


  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    amountController.text = "Choose a value"; //set the initial value of text field
    selectedBankAccount = noBankAccount; // Initialize with an empty string
    selectedCategory = noCategory; // Initialize with an empty string
    selectedBudget = noBudget; // Initialize with an empty string
    selectedTransactionType = TransactionType.actual; // Default value for TransactionType
    super.initState();
  }



  @override
  Widget build(BuildContext context) {


    void close(){
      Navigator.pop(context);
    }

    // access to the current user logged in
    final MyUser? user = Provider.of<MyUser?>(context); // get user info, logged in = unique id or null

    return MultiProvider(
    providers: [
      StreamProvider<List<Budget?>?>.value(
        value: DatabaseService(uid: user?.uid).userBudget,
        initialData: const []
      ),
      StreamProvider<List<c.Category?>?>.value(
        value: DatabaseService(uid: user?.uid).userCategory,
        initialData: const []
      ),
      StreamProvider<List<BankAccount?>?>.value(
        value: DatabaseService(uid: user?.uid).userBankAccount,
        initialData: const []
      ),
    ],
      child: HomeWrapperAdd(
        content: Form(
          key: _formkey,

          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10.0,),

                // Pick a name for the transaction form
                TextFormField(
                  initialValue: _currentName,
                  decoration: textInputDecoration, // constant.dart
                  validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() {
                    _currentName = val;
                  }),
                ),

                const SizedBox(height: 10.0,),
                // Pick an amount for transaction form
                TextFormField(
                  controller: amountController,
                  initialValue: amountValue,
                  onChanged: onChanged as void Function(String)?,
                  readOnly: false,
                  keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
                    TextInputFormatter.withFunction(
                          (oldValue, newValue) => newValue.copyWith(
                        text: newValue.text.replaceAll('.', ','),
                      ),
                    ),
                  ],
                  decoration: textInputDecoration,
                ),

                const SizedBox(height: 10.0,),
                // Pick a Date form
                TextField(
                  controller: dateInput,
                  //editing controller of this TextField
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: "Enter Date" //label text of field
                  ),
                  readOnly: true,
                  //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {}
                  },
                ),
                const SizedBox(height: 10.0,),

                // Pick a bank form
                Consumer<List<BankAccount?>?>(
                builder: (context, bankAccounts, child) {
                  // Create a list of DropdownMenuItem<BankAccount>
                  final dropdownItems = bankAccounts
                      ?.where((bankAccount) => bankAccount != null)
                      .map((bankAccount) {
                        return DropdownMenuItem<BankAccount?>(
                          value: bankAccount, // Use a default value or an empty string if ID is null
                          child: Text('BankAccount: ${bankAccount!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                        );
                  }).toList();
                  // Add an additional item for "no bank account"
                  dropdownItems?.insert(0, DropdownMenuItem<BankAccount?>(
                    value: noBankAccount, // Empty string for "no bank account"
                    child: Text(noBankAccount!.name),
                  ));

                  return Column (
                  children: [
                    // List of bank accounts the user has
                    DropdownButtonFormField<BankAccount?>(
                      decoration: textInputDecoration,
                      value: selectedBankAccount, // Set the selected bank account
                      items: dropdownItems,
                      onChanged: (newValue) =>
                          setState(() => selectedBankAccount = newValue!),
                    ),
                  ],
                  );
                }),
                const SizedBox(height: 10.0,),

                // Pick a category form
                Consumer<List<c.Category?>?>(
                    builder: (context, categories, child) {
                      // Create a list of DropdownMenuItem<c.Category>
                      final dropdownItems = categories?.where((category) => category != null).map((category) {
                        return DropdownMenuItem<c.Category>(
                          value: category, // Use a default value or an empty string if ID is null
                          child: Text('Category: ${category!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                        );
                      }).toList();
                      dropdownItems?.insert(0, DropdownMenuItem<c.Category>(
                        value: noCategory, // Empty string for "no category"
                        child: Text(noCategory!.name),
                      ));
                      return Column (
                        children: [
                          // List of bank accounts the user has
                          DropdownButtonFormField<c.Category>(
                            decoration: textInputDecoration,
                            value: selectedCategory ?? categories![0], // Set the selected bank account
                            items: dropdownItems,
                            onChanged: (newValue) =>
                                setState(() => selectedCategory = newValue!),
                          ),
                        ],
                      );
                    }),
                const SizedBox(height: 10.0,),

                // Pick a budget form
                Consumer<List<Budget?>?>(
                    builder: (context, budgets, child) {
                      // Create a list of DropdownMenuItem<BankAccount>
                      final dropdownItems = budgets?.where((budget) => budget != null).map((budget) {
                        return DropdownMenuItem<Budget>(
                          value: budget, // Use a default value or an empty string if ID is null
                          child: Text('Budget: ${budget!.name ?? 'Unnamed'}'), // Provide a default name if it's null
                        );
                      }).toList();
                      dropdownItems?.insert(0, DropdownMenuItem<Budget>(
                        value: noBudget, // Empty string for "no budget"
                        child: Text(noBudget!.name),
                      ));
                      return Column (
                        children: [
                          // List of bank accounts the user has
                          DropdownButtonFormField<Budget>(
                            decoration: textInputDecoration,
                            value: selectedBudget ?? budgets![0], // Set the selected bank account
                            items: dropdownItems,
                            onChanged: (newValue) =>
                                setState(() => selectedBudget = newValue!),
                          ),
                        ],
                      );
                    }),
                const SizedBox(height: 10.0,),

                // choose between recurring and non recurring
                Container(
                  color: Colors.white,
                  child: CheckboxListTile(
                    title: const Text(
                      'Recurring Transaction',
                      style: TextStyle(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    value: isRecurring,
                    //tristate: true, // allow a null state
                    checkColor: Colors.white,
                    activeColor: Colors.pink,
                    onChanged: (newValue) {
                      setState(() {
                        isRecurring = newValue!;
                        print('isRecurring: $isRecurring'); // Check if the value is updating
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10.0,),

                // choose between actual and expected
                DropdownButtonFormField<TransactionType>(
                  decoration: textInputDecoration,
                  value: selectedTransactionType,
                  items: TransactionType.values.map((type) {
                    return DropdownMenuItem<TransactionType>(
                      value: type,
                      child: Text(type.name.toString()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedTransactionType = newValue!;
                    });
                  },
                ),

                // update button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[400],
                  ),
                  onPressed: () async {

                    print('transaction name: $_currentName');
                    print('amount: ${amountController.text}');
                    print('date: $dateInput');
                    print('bank name: ${selectedBankAccount?.name} and the id is ${selectedBankAccount?.id}');
                    print('budget name: ${selectedBudget?.name} and the id is ${selectedBudget?.id}');
                    print('category name: ${selectedCategory?.name} and the id is ${selectedCategory?.id}');
                    print('recur: $isRecurring');
                    print('transa.type: $selectedTransactionType');

                    if(_formkey.currentState!.validate()){
                      // use the created budget to assign it to the user ID document in firestore
                      // await user?.createTransaction(
                      //     transactionName: transactionName,
                      //     amount: amount,
                      //     budget: budget,
                      //     category: category,
                      //     bankAccount: bankAccount,
                      //     date: date,
                      //     recurring: recurring,
                      //     transactionType: transactionType);
                      close(); // Navigate.pop(context)
                    }
                  },
                  child: const Text('Create transaction', style: TextStyle(color: Colors.white),),
                ),
              ],
            ),
          ),
        ), options: const TransactionSettingsForm(),

      ),
    );
  }
}
