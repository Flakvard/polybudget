import 'package:polybudget/features/budget/domain/budget.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  testWidgets('Budget class construction test', (WidgetTester tester) async {
    Budget budget = Budget(name: "Personal Budget", id: "123");

    expect(budget.name, "Personal Budget");
    expect(budget.id, "123");

  });

}