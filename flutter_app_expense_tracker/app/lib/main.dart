import 'package:app/widgets/transaction_list.dart';

import './models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  //const MyHomePage({super.key});
  final List<Transaction> transaction = [
   
  ];

  String titleInput;
  String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                child: Text('Chart!'),
                elevation: 5,
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(decoration: InputDecoration(labelText: 'Title'), onChanged: (value) {
                      titleInput = value;
                    }),
                    TextField(decoration: InputDecoration(labelText: 'Amount'),onChanged: (value) {
                      amountInput = value;
                    },),
                    ElevatedButton(onPressed: () {}, child: Text('Add Transaction'))
                  ],
                ),
              ),
            ),
            TransactionList()
          ],
          ),
    );
  }
}
