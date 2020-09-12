import 'package:flutter/material.dart';
import 'package:flutter_project_2/widgets/chart.dart';
import 'package:flutter_project_2/widgets/new_transaction.dart';
import 'package:flutter_project_2/widgets/transaction_list.dart';

import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new MyHomePage(),
        title: 'Personal Expenses',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.pink,
            errorColor: Colors.red,
            fontFamily: 'Roboto',
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                button: TextStyle(color: Colors.white)),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    button: TextStyle(color: Colors.white)))));
  }
}

// firstly we had statelesswidget but you need your variable to be final in order to uee statelesswidget
// you cannot change the variable's value in stateless widget it will give you warning
// for that use statefullwidget
class MyHomePage extends StatefulWidget {
  // String titleInputValue;
  // String amountInputValue;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: '1',
    //   title: 'Shoes',
    //   amount: 70.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '2',
    //   title: 'T-shirt',
    //   amount: 20.19,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    // it is used to check the particular value in the object
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewtransactions(
      String txTitle, double txAmount, DateTime selectedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: selectedDate);

    // https://stackoverflow.com/questions/51283077/when-use-setstate-in-flutter
    // Calling setState notifies the framework that the internal state of this object has changed in a way that might
    // impact the user interface in this subtree, which causes the framework to schedule a build for this State object.
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  void _bottomSheetOfAddTransaction(BuildContext mContext) {
    showModalBottomSheet(
        context: mContext,
        builder: (mBuildContext) {
          return GestureDetector(
            child: NewTransaction(_addNewtransactions),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App 2.0'),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => _bottomSheetOfAddTransaction(context))
        ],
      ),
      body: SingleChildScrollView(
        // For overall body scroll you can use SingleChildScrollView
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Personal Expenses!',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  )),
            ),
            Chart(_recentTransactions),
            TranscationList(_userTransaction, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _bottomSheetOfAddTransaction(context)),
    );
  }
}
