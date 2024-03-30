import 'package:flutter/material.dart';
import '../order.dart';

class AddOrderScreen extends StatefulWidget {
  final Function(Order) addOrderCallback;

  const AddOrderScreen({Key? key, required this.addOrderCallback}) : super(key: key);

  @override
  _AddOrderScreenState createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String customerName = '';
  String phoneNumber = '';
  double quantity = 1.0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  void _submitForm() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      Order order = Order(
        customerName: customerName,
        phoneNumber: phoneNumber,
        quantity: quantity,
        selectedDate: selectedDate,
        time: time,
      );
      print('Submitting form with order: $order'); // Add this line for debugging
      widget.addOrderCallback(order);
      // Navigate to the OrderListScreen (index 0 in the bottom navigation bar)
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushNamed('/');
    }
  }


  @override
  Widget build(BuildContext context) {
    print('Building AddOrderScreen'); // Add this line for debugging
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter customer name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      customerName = value ?? '';
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value ?? '';
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quantity > 1.0) {
                            quantity--;
                          }
                        });
                      },
                    ),
                    Text('Quantity: $quantity'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (quantity % 1 == 0) {
                            quantity += 0.5;
                          } else {
                            quantity -= 0.5;
                          }
                        });
                      },
                      child: const Text('Add 1/2'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Text('Select Date: ${selectedDate.toString().substring(0, 10)}'),
                ),
                ElevatedButton(
                  onPressed: () {
                    showTimePicker(
                      context: context,
                      initialTime: time,
                    ).then((pickedTime) {
                      if (pickedTime != null) {
                        setState(() {
                          time = pickedTime;
                        });
                      }
                    });
                  },
                  child: Text('Pickup Time: ${time.format(context)}'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Add Order'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
