import 'package:flutter/material.dart';
import 'order_tracking_screen.dart'; // នាំចូលទំព័រតាមដានការបញ្ជាទិញរបស់អ្នក
import 'order_history_screen.dart'; // នាំចូលទំព័រប្រវត្តិ និង globalOrderHistory
import 'global_data.dart'; // 👈 នាំចូល file កណ្តាលនេះ
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // 📍 អាសយដ្ឋានលំនាំដើម
  String _currentAddress = "Preaek Lieb, Phnom Penh";
  
  // 📞 លេខទូរសព្ទ
  final TextEditingController _phoneController = TextEditingController();

  // 💳 វិធីសាស្ត្រទូទាត់ប្រាក់
  String _selectedPaymentMethod = 'Cash on Delivery (Payment-on-Delivery)';

  // មុខងារសម្រាប់បង្ហាញ Dialog កែប្រែអាសយដ្ឋាន
  void _showChangeAddressDialog(BuildContext context) {
    TextEditingController addressController = TextEditingController(text: _currentAddress);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('កំណត់ទីតាំងដឹកជញ្ជូន'),
          content: TextField(
            controller: addressController,
            decoration: const InputDecoration(
              labelText: 'អាសយដ្ឋានថ្មី (Address)',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('បោះបង់', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD70F64),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _currentAddress = addressController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('រក្សាទុក'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= 1. Delivery Address =================
            const Text(
              'Delivery Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _showChangeAddressDialog(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFD70F64)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'អាសយដ្ឋានដឹកជញ្ជូន (Address)',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _currentAddress,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.edit, size: 18, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ================= 2. Phone Number =================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
                ],
              ),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  icon: Icon(Icons.phone, color: Color(0xFFD70F64)),
                  labelText: 'លេខទូរសព្ទ (Phone Number)',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ================= 3. Payment Method =================
            const Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPaymentMethod,
                  isExpanded: true,
                  items: <String>[
                    'Cash on Delivery (Payment-on-Delivery)',
                    'ABA Pay / Credit Card',
                    'ACLEDA Bank'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          const Icon(Icons.payment, color: Color(0xFFD70F64), size: 20),
                          const SizedBox(width: 12),
                          Text(value, style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPaymentMethod = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ================= 4. Order Summary =================
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
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: TextStyle(color: Colors.grey)),
                      Text('\$15.50', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee', style: TextStyle(color: Colors.grey)),
                      Text('\$1.00', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Divider(height: 20, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Total (incl. VAT)',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '\$16.50',
                        style: TextStyle(
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

            // ================= 5. Place Order Button =================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD70F64),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // 🛒 យកទិន្នន័យពីការបញ្ជាទិញ មកដាក់ចូល History ស្វ័យប្រវត្តិ
                  globalOrderHistory.insert(
                    0, 
                    OrderHistoryModel(
                      orderId: '98453', // លេខកូដបញ្ជាទិញ
                      foodName: 'Classic Cheeseburger & more',
                      price: '\$16.50',
                      status: 'កំពុងរៀបចំម្ហូប',
                    ),
                  );

                  // 🚀 រុញទៅកាន់ទំព័រ Tracking
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderTrackingScreen(orderId: '98453'),
                    ),
                  );
                },
                child: const Text(
                  'Place Order',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}