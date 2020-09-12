import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // the data wont go outside or multi line but the text or data will shrink
        Container(
          height: 15,
          child: FittedBox(child: Text('\$${spendingAmount.toStringAsFixed(0)}'))),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          //Stack allow you to add in top of each other. overlapping at each other kind of
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              // fractionla height
              FractionallySizedBox(
                heightFactor: spendingPercTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
