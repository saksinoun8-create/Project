import 'package:flutter/material.dart';
import 'global_data.dart'; // 👈 នាំចូល file កណ្តាលសម្រាប់ទិន្នន័យប្រវត្តិបញ្ជាទិញ

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // មុខងារបង្ហាញ Dialog រៀបរាប់ពីប្រវត្តិនៃការបញ្ជាទិញ
  void _showOrderHistoryDialog(BuildContext context, String orderId, String foodName, String price, String status) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFFFFF0F3), // ពណ៌ផ្ទៃខាងក្រោយផ្កាឈូកខ្ចី
          title: Text(
            'ការបញ្ជាទិញ #$orderId',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('មុខម្ហូប៖ $foodName', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              Text('តម្លៃសរុប៖ $price', style: const TextStyle(fontSize: 14, color: Color(0xFF28A745), fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text('ស្ថានភាព៖ $status', style: const TextStyle(fontSize: 14, color: Color(0xFFD70F64))),
              const SizedBox(height: 12),
              const Text(
                'បង្ហាញប្រវត្តិនៃការបញ្ជាទិញកន្លងមក',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD70F64), // ពណ៌ផ្កាឈូក Foodpanda
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              onPressed: () {
                Navigator.pop(context); // បិទ Dialog
              },
              child: const Text(
                'បិទ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
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
        title: const Text('ប្រវត្តិនៃការបញ្ជាទិញ (Order History)'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: globalOrderHistory.isEmpty
          ? const Center(
              child: Text(
                'មិនទាន់មានប្រវត្តិការបញ្ជាទិញនៅឡើយទេ',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: globalOrderHistory.length,
              itemBuilder: (context, index) {
                final order = globalOrderHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFFFFE8E8),
                      child: Icon(Icons.receipt_long, color: Color(0xFFD70F64)),
                    ),
                    title: Text(
                      'បញ្ជាទិញ #${order.orderId}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '${order.foodName} • ${order.price}',
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          order.status,
                          style: const TextStyle(color: Color(0xFF28A745), fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      // 🖱️ នៅពេលចុច វានឹងបង្ហាញ Dialog លម្អិត
                      _showOrderHistoryDialog(
                        context,
                        order.orderId,
                        order.foodName,
                        order.price,
                        order.status,
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}