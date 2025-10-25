import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:week_11/expense_data.dart';
import 'package:week_11/expense_model.dart';

class AddExpensePage extends StatefulWidget {
  final ExpenseModel? expense;

  const AddExpensePage({super.key, this.expense});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      _amountController.text = widget.expense!.amount.toString();
    }
  }

  void _saveExpense() async {
    if (!_formKey.currentState!.validate()) return;

    final expense = ExpenseModel(
      id: widget.expense?.id ?? const Uuid().v4(),
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: DateTime.now(),
    );

    if (widget.expense == null) {
      await ExpenseData.addExpense(expense);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pengeluaran ditambahkan!"), backgroundColor: Colors.green),
      );
    } else {
      await ExpenseData.editExpense(expense);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pengeluaran diperbarui!"), backgroundColor: Colors.blue),
      );
    }

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.expense == null ? "Tambah Pengeluaran" : "Edit Pengeluaran",
            style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0bc4ff),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Nama Pengeluaran"),
                validator: (value) => value == null || value.isEmpty ? "Tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: "Jumlah (Rp)"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Masukkan nominal" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0bc4ff)),
                onPressed: _saveExpense,
                child: const Text("Simpan", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
