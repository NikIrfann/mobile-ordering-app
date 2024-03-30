// order.dart

import 'package:flutter/material.dart';

class Order {
  final String customerName;
  final String phoneNumber;
  final double quantity;
  final DateTime selectedDate;
  final TimeOfDay time;

  Order({
    required this.customerName,
    required this.phoneNumber,
    required this.quantity,
    required this.selectedDate,
    required this.time,
  });

  @override
  String toString() {
    return 'Order { customerName: $customerName, phoneNumber: $phoneNumber, quantity: $quantity, selectedDate: $selectedDate, time: $time }';
  }
}

