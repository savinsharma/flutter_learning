import 'package:flutter/material.dart';
import 'package:flutter_project_2/models/transaction.dart';
import 'package:flutter_project_2/widgets/char_bar.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions); 

  //get is getter(setter,getter)
  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(
        days: index,
      )); // this will get dates. lets say today the subtract -1 will give yesterday then day before yesterday so on.

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekDay));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList(); // to reverse the list
  }

  double get totalWeekSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupTransactionValues.map((data) {
              // Text('${data['day']} : ${data['amount']}')
              // Flexible is used to distribute space between items.
              // With flexible tight the data won't go outise of the width provided. If you have added a text it will go multi line
              // flex key is use to manage the weight
              // flexible is sort of weightSum
              // for flexFit.tight = you can use Expanded widget
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'],
                    data['amount'],
                    totalWeekSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalWeekSpending),
              );
            }).toList()),
      ),
    );
  }
}
