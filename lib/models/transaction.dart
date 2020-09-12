import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  // to use required use import foundation.dart
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
