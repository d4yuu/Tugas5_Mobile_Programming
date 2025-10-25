import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week_11/expense_model.dart';
import 'package:week_11/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>("expensesBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
