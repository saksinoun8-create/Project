import 'package:flutter/material.dart';
import 'order_tracking_screen.dart'; // នាំចូលទំព័រតាមដានការដឹកជញ្ជូន

// 1. Model សម្រាប់ទំនិញក្នុងកន្ត្រក
class CartItemModel {
  final String title;
  final String subtitle;
  final double price;
  int quantity;
  final String imageUrl;

  CartItemModel({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

// Global List សម្រាប់ផ្ទុកទំនិញដែលបានចុចកុម្មង់
List<CartItemModel> globalCartItems = [];

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  // គណនាតម្លៃសរុប (Subtotal)
  double get _totalAmount {
    return globalCartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: globalCartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: globalCartItems.length,
                    itemBuilder: (context, index) {
                      final item = globalCartItems[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.subtitle,
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Color(0xFFD70F64),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ប៊ូតុងដំឡើង / បន្ថយចំនួន quantity
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline, size: 20),
                                  onPressed: () {
                                    setState(() {
                                      if (item.quantity > 1) {
                                        item.quantity--;
                                      } else {
                                        globalCartItems.removeAt(index);
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline, size: 20, color: Color(0xFFD70F64)),
                                  onPressed: () {
                                    setState(() {
                                      item.quantity++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // ផ្នែកបាតសម្រាប់បង្ហាញតម្លៃសរុប និងប៊ូតុង Review payment
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total:', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          Text(
                            '\$${(_totalAmount + 1.00).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD70F64),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD70F64),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // 🚀 លោតទៅកាន់ទំព័រ ReviewPaymentScreen ព្រមទាំងផ្ញើតម្លៃសរុបទៅជាមួយ
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewPaymentScreen(totalAmount: _totalAmount),
                            ),
                          );
                        },
                        child: const Text('Review payment', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

// ==========================================
// 2. ទំព័រពិនិត្យការទូទាត់ប្រាក់ (ReviewPaymentScreen) - រួមបញ្ចូលទាំង TextField និង Summary បែបស្អាត
// ==========================================
class ReviewPaymentScreen extends StatefulWidget {
  final double totalAmount;

  const ReviewPaymentScreen({super.key, required this.totalAmount});

  @override
  State<ReviewPaymentScreen> createState() => _ReviewPaymentScreenState();
}

class _ReviewPaymentScreenState extends State<ReviewPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController(
    text: 'Preaek Lieb, Phnom Penh',
  );
  final TextEditingController _phoneController = TextEditingController();
  String _selectedPaymentMethod = 'Cash on Delivery (Payment-on-Delivery)';

  @override
  Widget build(BuildContext context) {
    double deliveryFee = 1.00;
    double finalTotal = widget.totalAmount + deliveryFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFFD70F64),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // ផ្នែក Delivery Address (រួមបញ្ចូលទាំង Icon និង TextFormField)
              const Text(
                'Delivery Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFD70F64)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'អាសយដ្ឋានដឹកជញ្ជូន (Address)',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        validator: (value) => value!.isEmpty ? 'សូមបញ្ចូលអាសយដ្ឋាន' : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // បន្ថែម TextField លេខទូរសព្ទ
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'លេខទូរសព្ទ (Phone Number)',
                    border: InputBorder.none,
                    icon: Icon(Icons.phone, color: Color(0xFFD70F64)),
                  ),
                  validator: (value) => value!.isEmpty ? 'សូមបញ្ចូលលេខទូរសព្ទ' : null,
                ),
              ),
              const SizedBox(height: 20),

              // ផ្នែក Payment Method
              const Text(
                'Payment Method',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedPaymentMethod,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.payment, color: Color(0xFFD70F64)),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Cash on Delivery (Payment-on-Delivery)',
                      child: Text('Cash on Delivery (Payment-on-Delivery)'),
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
              ),
              const SizedBox(height: 20),

              // ផ្នែក Order Summary
              const Text(
                'Order Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal', style: TextStyle(color: Colors.grey)),
                        Text('\$${widget.totalAmount.toStringAsFixed(2)}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Fee', style: TextStyle(color: Colors.grey)),
                        Text('\$${deliveryFee.toStringAsFixed(2)}'),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total (incl. VAT)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(
                          '\$${finalTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFFD70F64),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // ប៊ូតុង Place Order
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD70F64),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // 🚀 រុញទៅកាន់ទំព័រ OrderTrackingScreen
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderTrackingScreen(orderId: '98452'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Place Order',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}