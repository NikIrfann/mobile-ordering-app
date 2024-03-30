import 'package:flutter/material.dart';
import 'screens/add_order_screen.dart';
import 'screens/update_order_screen.dart';
import 'screens/order_list_screen.dart';
import 'order.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Order> ordersList = []; // Initialize an empty list of orders

    return MaterialApp(
      title: 'Order Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Dashboard(orders: ordersList), // Pass the list of orders to Dashboard
    );
  }
}

class Dashboard extends StatefulWidget {
  final List<Order> orders;

  Dashboard({Key? key, required this.orders}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      OrderListScreen(orders: widget.orders),
      AddOrderScreen(addOrderCallback: _addOrder), // Pass the callback function
      UpdateOrderScreen(),
    ];
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addOrder(Order order) {
    setState(() {
      widget.orders.add(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Management App'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Update Order',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
