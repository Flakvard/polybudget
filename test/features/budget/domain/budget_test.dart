import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';

void main(){


  testWidgets('Budget class construction test', (WidgetTester tester) async {
    Budget budget = Budget(name: "Personal Budget", id: "123");

    expect(budget.name, "Personal Budget");
    expect(budget.id, "123");
  });

  testWidgets('Budget class construction with json test', (WidgetTester tester) async {
    const encoded = '{"id": "123","name": "Personal Budget"}';
    var budgetJson = jsonDecode(encoded);
    print('${budgetJson.runtimeType} : $budgetJson');

    Budget budget = Budget.fromJson(budgetJson);

    expect(budget.name, "Personal Budget");
    expect(budget.id, "123");

  });

}