import 'package:flutter/material.dart';
import 'carts.dart'; // នាំចូល file Cart របស់អ្នក

class DessertItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const DessertItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class DessertListScreen extends StatelessWidget {
  const DessertListScreen({super.key});

  final List<DessertItem> desserts = const [
    DessertItem(
      name: 'Chocolate Lava Cake',
      description: 'Warm chocolate cake with a gooey, molten chocolate center.',
      price: 4.50,
      imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500',
    ),
    DessertItem(
      name: 'Strawberry Cheesecake',
      description: 'Creamy New York style cheesecake topped with fresh strawberries.',
      price: 4.80,
      imageUrl: 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=500',
    ),
    DessertItem(
      name: 'Matcha Green Tea Crepe',
      description: 'Delicate multi-layered crepe filled with rich matcha cream.',
      price: 5.00,
      imageUrl: 'https://images.unsplash.com/photo-1541781774459-bb2af2f05b55?w=500',
    ),
    DessertItem(
      name: 'Classic Tiramisu',
      description: 'Italian coffee-flavored dessert with mascarpone cheese and cocoa.',
      price: 5.25,
      imageUrl: 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=500',
    ),
    DessertItem(
      name: 'Mango Sticky Rice',
      description: 'Sweet coconut sticky rice served with fresh ripe mango slices.',
      price: 4.00,
      imageUrl: 'https://images.unsplash.com/photo-1541658016709-82535e94bc69?w=500',
    ),
    DessertItem(
      name: 'Vanilla Waffle with Ice Cream',
      description: 'Crispy golden waffle served with a scoop of vanilla ice cream and syrup.',
      price: 4.75,
      imageUrl: 'https://images.unsplash.com/photo-1562376552-0d160a2f238d?w=500',
    ),
    DessertItem(
      name: 'Blueberry Muffin',
      description: 'Soft and fluffy buttery muffin packed with juicy blueberries.',
      price: 3.00,
      imageUrl: 'https://images.unsplash.com/photo-1607958996333-41aef7caefcc?w=500',
    ),
    DessertItem(
      name: 'Caramel Macaron Set',
      description: 'Assorted French almond macarons with smooth salted caramel filling.',
      price: 6.00,
      imageUrl: 'https://images.unsplash.com/photo-1569864358642-9d1684040f43?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍰 Desserts Menu'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: desserts.length,
        itemBuilder: (context, index) {
          final dessert = desserts[index];
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
                    dessert.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                // 📝 បង្ហាញព័ត៌មានបង្អែម
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dessert.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        dessert.description,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${dessert.price.toStringAsFixed(2)}',
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
                        title: dessert.name,
                        subtitle: 'Dessert Shop',
                        price: dessert.price,
                        quantity: 1,
                        imageUrl: dessert.imageUrl,
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