import 'package:flutter/material.dart';
import 'carts.dart'; // នាំចូល file Cart របស់អ្នក

class BurgerItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const BurgerItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class BurgerListScreen extends StatelessWidget {
  const BurgerListScreen({super.key});

  final List<BurgerItem> burgers = const [
    BurgerItem(
      name: 'Classic Cheeseburger',
      description: 'Loaded with double beef patties and melted cheese.',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
    ),
    BurgerItem(
      name: 'Double Beef Bacon',
      description: 'Topped with crispy bacon and special burger sauce.',
      price: 6.25,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
    ),
    BurgerItem(
      name: 'Spicy Chicken Burger',
      description: 'Crispy fried chicken breast with spicy Korean sauce.',
      price: 5.00,
      imageUrl: 'https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=500',
    ),
    BurgerItem(
      name: 'Mushroom Swiss Burger',
      description: 'Juicy beef patty topped with sautéed mushrooms and Swiss cheese.',
      price: 5.75,
      imageUrl: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍔 Burgers Menu'),
        backgroundColor: const Color(0xFFD70F64),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: burgers.length,
        itemBuilder: (context, index) {
          final burger = burgers[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(burger.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(burger.description, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text('\$${burger.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF28A745))),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD70F64),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () {
                    // 🛒 ឆ្កឹះបន្ថែមចូល globalCartItems
                    globalCartItems.add(
                      CartItemModel(
                        title: burger.name,
                        subtitle: 'Burger Shop',
                        price: burger.price,
                        quantity: 1,
                        imageUrl: burger.imageUrl,
                      ),
                    );

                    // 🚀 រុញទៅកាន់ទំព័រ CartsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartsScreen(),
                      ),
                    );
                  },
                  child: const Text('Order Now'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}