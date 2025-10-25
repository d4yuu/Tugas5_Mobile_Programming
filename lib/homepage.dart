import 'package:flutter/material.dart';
import 'package:week_11/add_expense_page.dart';
import 'package:week_11/expense_data.dart';
import 'package:week_11/expense_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExpenseModel> expenses = [];

  void _loadData() {
    setState(() {
      expenses = ExpenseData.getExpenses();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _deleteItem(String id) async {
    await ExpenseData.deleteExpense(id);
    _loadData();
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Data pengeluaran dihapus"),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _editItem(ExpenseModel expense) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddExpensePage(expense: expense)),
    );
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF2196F3),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF2196F3),
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpensePage()),
          );
          _loadData();
        },
      ),
      body: expenses.isEmpty
          ? const Center(
              child: Text("Belum ada pengeluaran 😢", style: TextStyle(color: Colors.grey)),
            )
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final e = expenses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.money, color: Colors.green),
                    title: Text(e.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("Rp ${e.amount.toStringAsFixed(0)}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editItem(e),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteItem(e.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
