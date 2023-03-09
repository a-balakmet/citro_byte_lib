import 'dart:math' as math;
import 'package:intl/intl.dart';

extension NumExtension on num {
  bool isBetween(num from, num to) => from <= this && this <= to;

  String numToDecimal() {
    final formatter = NumberFormat.decimalPattern('ru');
    return formatter.format(this);
  }

  bool get isInt => (this % 1) == 0;

  double deg2rad() => this * (math.pi / 180);

  DateTime intToDate() => DateTime.fromMillisecondsSinceEpoch(round() * 1000);
}
