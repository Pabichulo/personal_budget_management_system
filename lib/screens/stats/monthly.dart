import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_budget_managemet/screens/stats/piechart_monthly.dart';

import 'chart_monthly.dart';

class MonthlyTransactionsScreen extends StatefulWidget {
  final List<Expense> expenses;

  const MonthlyTransactionsScreen(this.expenses, {super.key});

  @override
  State<MonthlyTransactionsScreen> createState() => _MonthlyTransactionsScreenState();
}

class _MonthlyTransactionsScreenState extends State<MonthlyTransactionsScreen> {
  late List<Expense> expenses;
  late String selectedMonth;
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  @override
  void initState() {
    super.initState();
    expenses = widget.expenses;
    selectedMonth = DateFormat('MMMM').format(DateTime.now());
  }

  void filterExpensesByMonth(String month) {
    setState(() {
      expenses = widget.expenses.where((expense) {
        final expenseMonth = DateFormat('MMMM').format(expense.date);
        return expenseMonth == month;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Transactions'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white, // Set background color to white
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedMonth,
                  items: months.map((String month) {
                    return DropdownMenuItem<String>(
                      value: month,
                      child: Text(month),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Select Month',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    filterExpensesByMonth(selectedMonth);
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                    child: MyMonthlyChart(expenses),
                  ),
                ),
                const SizedBox(height: 20), // Space between the two charts
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                    child: MyMonthlyPieChart(expenses), // Pie chart widget
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
