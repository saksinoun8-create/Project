import 'package:flutter/material.dart';
import 'carts.dart'; // នាំចូល file Cart របស់អ្នក

class AsianItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const AsianItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class AsianListScreen extends StatelessWidget {
  const AsianListScreen({super.key});

  final List<AsianItem> asianDishes = const [
    AsianItem(
      name: 'Cambodian Lok Lak',
      description: 'Tender stir-fried beef cubes served with fresh salad and pepper lime dip.',
      price: 5.50,
      imageUrl: 'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?w=500',
    ),
    AsianItem(
      name: 'Pad Thai Noodles',
      description: 'Stir-fried rice noodles with shrimp, peanuts, and bean sprouts.',
      price: 4.75,
      imageUrl: 'https://images.unsplash.com/photo-1559847844-5315695dadae?w=500',
    ),
    AsianItem(
      name: 'Japanese Ramen',
      description: 'Rich tonkotsu pork broth with noodles, soft-boiled egg, and chashu.',
      price: 6.50,
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
    ),
    AsianItem(
      name: 'Chinese Fried Rice',
      description: 'Wok-tossed fragrant rice with eggs, vegetables, and chicken.',
      price: 4.25,
      imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🥢 Asian Food Menu'),
        backgroundColor: const Color(0xFFD70F64),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: asianDishes.length,
        itemBuilder: (context, index) {
          final dish = asianDishes[index];
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
                // 🖼️ បន្ថែមរូបភាពនៅខាងឆ្វេង
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    dish.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                // 📝 បង្ហាញព័ត៌មានម្ហូប
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dish.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        dish.description,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${dish.price.toStringAsFixed(2)}',
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
                        title: dish.name,
                        subtitle: 'Asian Kitchen',
                        price: dish.price,
                        quantity: 1,
                        imageUrl: dish.imageUrl,
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