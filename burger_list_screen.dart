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
      imageUrl: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=500',
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
      imageUrl: 'https://images.unsplash.com/photo-1550547660-d9450f859349?w=500',
    ),
    BurgerItem(
      name: 'BBQ Smokehouse Burger',
      description: 'Grilled beef with onion rings, cheddar, and smoky BBQ sauce.',
      price: 6.00,
      imageUrl: 'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=500',
    ),
    BurgerItem(
      name: 'Crispy Fish Burger',
      description: 'Golden fried fish fillet with fresh lettuce and tartar sauce.',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=500',
    ),
    BurgerItem(
      name: 'Avocado Veggie Burger',
      description: 'Plant-based patty with fresh avocado slices and vegan mayo.',
      price: 5.20,
      imageUrl: 'https://images.unsplash.com/photo-1525059696034-4967a8e1dca2?w=500',
    ),
    BurgerItem(
      name: 'Truffle Burger',
      description: 'Beef patty infused with luxurious truffle oil and sharp cheddar.',
      price: 7.50,
      imageUrl: 'https://images.unsplash.com/photo-1585238342024-78d387f4a707?w=500',
    ),
    BurgerItem(
      name: 'Jalapeno Fire Burger',
      description: 'Spicy jalapenos, pepper jack cheese, and fiery chipotle mayo.',
      price: 5.90,
      imageUrl: 'https://images.unsplash.com/photo-1551782450-17144efb9c50?w=500',
    ),
    BurgerItem(
      name: 'Egg & Bacon Burger',
      description: 'Classic beef patty topped with a sunny-side-up egg and bacon.',
      price: 6.40,
      imageUrl: 'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=500',
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
                    burger.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                // 📝 បង្ហាញព័ត៌មានប៊ើហ្គឺ
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(burger.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        burger.description,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${burger.price.toStringAsFixed(2)}',
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
                    globalCartItems.add(
                      CartItemModel(
                        title: burger.name,
                        subtitle: 'Burger Shop',
                        price: burger.price,
                        quantity: 1,
                        imageUrl: burger.imageUrl,
                      ),
                    );

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