import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/transaction.dart';
import 'package:intl/intl.dart'; // this is for date format, localization, multi language and stuff. add it in pubspec.yaml file.

class TranscationList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteFunction;

  TranscationList(this.transactions, this.deleteFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No Transaction found',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ), // invisible box used to add margin or space between 2 views
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/attendee_not_found.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                          child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteFunction(transactions[index].id)),
                  ),
                );

                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //           color: Theme.of(context).primaryColor,
                //           width: 2,
                //         )),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}', // $ means using a value in concate. if you want to use $ as string then add backslash
                //           style: Theme.of(context)
                //               .textTheme
                //               .title, // it is created in main.dart
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .title, // it is created in main.dart
                //           ),
                //           Text(
                //             DateFormat.yMMMMd().format(transactions[index]
                //                 .date), // to use own date pattern add DateFormat('dd-MMMM-yyyy')
                //             style: TextStyle(
                //                 fontWeight: FontWeight.normal, fontSize: 12),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
