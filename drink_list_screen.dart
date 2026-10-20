import 'package:flutter/material.dart';
import 'carts.dart'; // នាំចូល file Cart របស់អ្នក

class DrinkItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const DrinkItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class DrinkListScreen extends StatelessWidget {
  const DrinkListScreen({super.key});

  final List<DrinkItem> drinks = const [
    DrinkItem(
      name: 'Iced Caramel Macchiato',
      description: 'Espresso combined with vanilla syrup, milk, and caramel drizzle over ice.',
      price: 3.50,
      imageUrl: 'https://images.unsplash.com/photo-1485808191679-edf8637cb6a9?w=500',
    ),
    DrinkItem(
      name: 'Classic Milk Tea with Pearls',
      description: 'Sweet black milk tea served with chewy brown sugar tapioca pearls.',
      price: 3.00,
      imageUrl: 'https://images.unsplash.com/photo-1541658016709-82535e94bc69?w=500',
    ),
    DrinkItem(
      name: 'Fresh Mango Smoothie',
      description: 'Thick and refreshing blended fresh mango with milk and ice.',
      price: 3.75,
      imageUrl: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=500',
    ),
    DrinkItem(
      name: 'Matcha Green Tea Latte',
      description: 'Premium Japanese matcha green tea whisked with fresh creamy milk.',
      price: 4.00,
      imageUrl: 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500',
    ),
    DrinkItem(
      name: 'Lemon Honey Tea',
      description: 'Soothing black tea infused with fresh lemon juice and organic honey.',
      price: 2.75,
      imageUrl: 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500',
    ),
    DrinkItem(
      name: 'Chocolate Frappe',
      description: 'Blended iced chocolate topped with whipped cream and chocolate syrup.',
      price: 4.25,
      imageUrl: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500',
    ),
    DrinkItem(
      name: 'Strawberry Fruit Tea',
      description: 'Refreshing jasmine green tea infused with strawberry bits and jelly.',
      price: 3.25,
      imageUrl: 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500',
    ),
    DrinkItem(
      name: 'Passion Fruit Soda',
      description: 'Sparkling soda mixed with tangy passion fruit pulp and mint leaves.',
      price: 3.00,
      imageUrl: 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧋 Drinks Menu'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: drinks.length,
        itemBuilder: (context, index) {
          final drink = drinks[index];
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
                    drink.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                // 📝 បង្ហាញព័ត៌មានភេសជ្ជៈ
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(drink.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        drink.description,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${drink.price.toStringAsFixed(2)}',
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
                        title: drink.name,
                        subtitle: 'Drink Shop',
                        price: drink.price,
                        quantity: 1,
                        imageUrl: drink.imageUrl,
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