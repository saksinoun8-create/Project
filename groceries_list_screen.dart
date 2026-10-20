import 'package:flutter/material.dart';
import 'carts.dart'; // នាំចូល file Cart របស់អ្នក

class GroceryItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const GroceryItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class GroceriesListScreen extends StatelessWidget {
  const GroceriesListScreen({super.key});

  final List<GroceryItem> groceries = const [
    GroceryItem(
      name: 'Fresh Organic Milk',
      description: 'Pure 100% fresh cow milk rich in calcium and vitamins (1 Liter).',
      price: 2.50,
      imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=500',
    ),
    GroceryItem(
      name: 'Whole Wheat Bread',
      description: 'Freshly baked healthy whole grain sliced bread.',
      price: 2.00,
      imageUrl: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?w=500',
    ),
    GroceryItem(
      name: 'Fresh Farm Eggs (10pcs)',
      description: 'Grade A fresh chicken eggs packed securely.',
      price: 3.20,
      imageUrl: 'https://images.unsplash.com/photo-1516448702985-802c67923485?w=500',
    ),
    GroceryItem(
      name: 'Fresh Red Apples (1kg)',
      description: 'Crisp, sweet, and juicy fresh imported red apples.',
      price: 4.00,
      imageUrl: 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=500',
    ),
    GroceryItem(
      name: 'Ripe Cavendish Bananas',
      description: 'Sweet and nutritious yellow bananas, rich in potassium.',
      price: 1.80,
      imageUrl: 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=500',
    ),
    GroceryItem(
      name: 'Fresh Broccoli',
      description: 'Green and crispy organic broccoli heads, high in fiber.',
      price: 2.30,
      imageUrl: 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=500',
    ),
    GroceryItem(
      name: 'Cheddar Cheese Block',
      description: 'Rich and creamy aged cheddar cheese (250g).',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1452195100486-9cc805987862?w=500',
    ),
    GroceryItem(
      name: 'Pure Olive Oil',
      description: 'Extra virgin olive oil ideal for cooking and salads (500ml).',
      price: 7.50,
      imageUrl: 'https://images.unsplash.com/photo-1474979266404-7eaacbcd87c5?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Groceries Menu'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: groceries.length,
        itemBuilder: (context, index) {
          final grocery = groceries[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
              ],
            ),
            child: Row(
              children: [
                // 🖼️ បង្ហាញរូបភាពនៅខាងឆ្វេង
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    grocery.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                // 📝 បង្ហាញព័ត៌មានទំនិញ
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(grocery.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        grocery.description,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${grocery.price.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF28A745)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // 🛒 ប៊ូតុងបញ្ជាទិញ
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD70F64),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  onPressed: () {
                    // 🛒 បន្ថែមចូល globalCartItems
                    globalCartItems.add(
                      CartItemModel(
                        title: grocery.name,
                        subtitle: 'Grocery Shop',
                        price: grocery.price,
                        quantity: 1,
                        imageUrl: grocery.imageUrl,
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
                  child: const Text('Order', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}