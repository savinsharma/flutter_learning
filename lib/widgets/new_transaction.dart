import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  // text editing controller will give you listen the input and save the value and give you in return for statelesswidget.

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleTextEditingController = TextEditingController();
  final amountTextEditingController = TextEditingController();
  DateTime _selectedDate;

  void _submitTransactionData() {
    if (amountTextEditingController.text.isEmpty) {
      return;
    }
    final enterValueTitle = titleTextEditingController.text;
    final enterValueAmount = double.parse(amountTextEditingController.text);

    if (enterValueTitle.isNotEmpty &&
        enterValueAmount > 0 &&
        _selectedDate != null) {
      widget.addNewTransaction(
          enterValueTitle, enterValueAmount, _selectedDate,);

      // this is to dismiss the popup screen. i.e., it will dismiss the bottom sheet after adding data.
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  void _dataPickerFunc() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    // then will be called when user select any date
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              cursorColor: Colors.orange,
              autofocus: false,
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleTextEditingController,
              onSubmitted: (idontusethis) =>
                  _submitTransactionData(), // here on submit takes an parameter in the function which is of no use. So either add a parameter in the function or do this second solution
              // idontusethis is the other way if you don't want to add the parameter.
            ),
            TextField(
              cursorColor: Colors.orange,
              autofocus: false,
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountTextEditingController,
              keyboardType: TextInputType.number,
              onSubmitted: (idontusethis) =>
                  _submitTransactionData(), // here on submit takes an parameter in the function which is of no use. So either add a parameter in the function or do this second solution
              // idontusethis is the other way if you don't want to add the parameter.
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  // expanded - text will take all the free space. it is like adding weight 1 in linear layout
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date chosen'
                        : 'Picked Date: ${DateFormat.yMMMEd().format(_selectedDate)}'),
                  ),
                  FlatButton(
                    onPressed: _dataPickerFunc,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            FlatButton(
              child: Text('Add Transaction'),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: _submitTransactionData,
            )
          ],
        ),
      ),
    );
  }
}
