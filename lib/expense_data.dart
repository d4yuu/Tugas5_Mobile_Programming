import 'package:hive/hive.dart';
import 'expense_model.dart';

class ExpenseData {
  static const String boxName = "expensesBox";

  //nambahkan expense dengan id
  static Future<void> addExpense(ExpenseModel expense) async {
    final box = Hive.box<ExpenseModel>(boxName);
    await box.put(expense.id, expense);
  }

  //mengambil data expense
  static List<ExpenseModel> getExpenses() {
    final box = Hive.box<ExpenseModel>(boxName);
    return box.values.toList();
  }

  //menghapus expense
  static Future<void> deleteExpense(String id) async {
    final box = Hive.box<ExpenseModel>(boxName);
    await box.delete(id);
  }

  //edit expense
  static Future<void> editExpense(ExpenseModel updated) async {
    final box = Hive.box<ExpenseModel>(boxName);
    await box.put(updated.id, updated);
  }
}
