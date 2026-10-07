import 'package:flutter/material.dart';
import 'order_tracking_screen.dart'; 


class PaymentScreen extends StatefulWidget {
  final List<dynamic> cart; 
  final double totalAmount;

  const PaymentScreen({
    super.key,
    required this.cart,
    required this.totalAmount,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController(
    text: 'Tuol Sangke, Phnom Penh',
  );
  final TextEditingController _phoneController = TextEditingController();
  String _selectedPaymentMethod = 'Cash on Delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ការទូទាត់ប្រាក់ (Checkout)'),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'ព័ត៌មានទីតាំងដឹកជញ្ជូន',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'អាសយដ្ឋានដឹកជញ្ជូន (Address)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'សូមបញ្ចូលអាសយដ្ឋាន' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'លេខទូរសព្ទ (Phone Number)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'សូមបញ្ចូលលេខទូរសព្ទ' : null,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: const InputDecoration(
                  labelText: 'វិធីសាស្ត្រទូទាត់ប្រាក់',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Cash on Delivery',
                    child: Text('ទូទាត់ពេលទទួលបានទំនិញ (Cash)'),
                  ),
                  DropdownMenuItem(
                    value: 'ABA Pay / KHQR',
                    child: Text('ABA Pay / KHQR'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'សេចក្តីសង្ខេបការបញ្ជាទិញ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ...widget.cart.map(
                      (item) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${item.pizza.name} x${item.quantity}'),
                          Text(
                            '\$${(item.pizza.price * item.quantity).toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ទឹកប្រាក់សរុប:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${widget.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // រុញទៅកាន់ទំព័រតាមដានការដឹកជញ្ជូន និងលុបប្រវត្តិទំព័រ Payment ចោល
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderTrackingScreen(orderId: '98452'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'បញ្ជាក់ការបញ្ជាទិញ (Place Order)',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}