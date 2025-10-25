import 'package:hive/hive.dart';
import 'expense_model.dart';

class ExpenseData {
  static const String boxName = "expensesBox";

  static Future<void> addExpense(ExpenseModel expense) async {
    final box = Hive.box<ExpenseModel>(boxName);
    await box.put(expense.id, expense);
  }

  static List<ExpenseModel> getExpenses() {
    final box = Hive.box<ExpenseModel>(boxName);
    return box.values.toList();
  }

  static Future<void> deleteExpense(String id) async {
    final box = Hive.box<ExpenseModel>(boxName);
    await box.delete(id);
  }

  static Future<void> editExpense(ExpenseModel updated) async {
    final box = Hive.box<ExpenseModel>(boxName);
    await box.put(updated.id, updated);
  }
}
