import 'package:flutter/material.dart';
import '../order.dart';

// Import the Order class from another file if it's defined there
// class Order {
//   final String customerName;
//   final String phoneNumber;
//   final double quantity;
//   final DateTime selectedDate;
//   final TimeOfDay time;

//   Order({
//     required this.customerName,
//     required this.phoneNumber,
//     required this.quantity,
//     required this.selectedDate,
//     required this.time,
//   });
// }

class OrderListScreen extends StatelessWidget {
  final List<Order> orders;

  const OrderListScreen({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isHorizontal = orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order List'),
      ),
      body: isHorizontal
          ? _buildHorizontalLayout()
          : _buildVerticalLayout(),
    );
  }

  Widget _buildHorizontalLayout() {
    return Column(
      children: [
        _buildLabelsRow(),
        Expanded(child: _buildOrderList()),
      ],
    );
  }

  Widget _buildVerticalLayout() {
    return ListView(
      children: [
        _buildLabelsRow(),
        _buildOrderList(),
      ],
    );
  }

  Widget _buildLabelsRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: Text('Name:')),
          Expanded(child: Text('Phone Number:')),
          Expanded(child: Text('Date:')),
          Expanded(child: Text('Time:')),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text(order.customerName)),
                Expanded(child: Text(order.phoneNumber)),
                Expanded(child: Text(order.selectedDate.toString().substring(0, 10))),
                Expanded(child: Text(order.time.format(context))),
              ],
            ),
          ),
        );
      },
    );
  }
}




