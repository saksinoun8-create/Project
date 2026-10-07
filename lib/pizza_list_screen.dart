import 'package:flutter/material.dart';
import 'order_tracking_screen.dart'; // នាំចូលទំព័រតាមដានការដឹកជញ្ជូន

// ==========================================
// 1. ម៉ូឌែលទិន្នន័យភីហ្សា (Pizza Model)
// ==========================================
class PizzaItem {
  final String name;
  final String description;
  final double price;

  PizzaItem({required this.name, required this.description, required this.price});
}

// ==========================================
// 2. ទំព័ររាយបញ្ជីភីហ្សា (Pizza List Screen)
// ==========================================
class PizzaListScreen extends StatelessWidget {
  const PizzaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // បញ្ជីមុខម្ហូប Pizza ទាំង ៦
    final List<PizzaItem> pizzas = [
      PizzaItem(
        name: 'Cheese Pizza',
        description: 'Loaded with extra mozzarella cheese.',
        price: 8.50,
      ),
      PizzaItem(
        name: 'Hot Dog Pizza',
        description: 'Topped with savory hot dog slices and special sauce.',
        price: 9.50,
      ),
      PizzaItem(
        name: 'Pepperoni Supreme',
        description: 'Packed with double pepperoni and rich tomato sauce.',
        price: 10.00,
      ),
      PizzaItem(
        name: 'Seafood Deluxe',
        description: 'Shrimp, squid, and crab sticks with garlic butter.',
        price: 11.50,
      ),
      PizzaItem(
        name: 'BBQ Chicken Pizza',
        description: 'Grilled chicken, onions, and smoky BBQ sauce.',
        price: 9.75,
      ),
      PizzaItem(
        name: 'Hawaiian Paradise',
        description: 'Sweet pineapple chunks, ham, and extra cheese.',
        price: 9.00,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🍕 Pizza Menu'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final pizza = pizzas[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              title: Text(
                pizza.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(pizza.description, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(
                    '\$${pizza.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF28A745),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD70F64),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {
                  // 🚀 នៅពេលចុច Order Now វានឹងរុញទៅកាន់ទំព័រតាមដានការបញ្ជាទិញ (OrderTrackingScreen) ផ្ទាល់តែម្តង
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderTrackingScreen(orderId: '98452'),
                    ),
                  );
                },
                child: const Text('Order Now'),
              ),
            ),
          );
        },
      ),
    );
  }
}