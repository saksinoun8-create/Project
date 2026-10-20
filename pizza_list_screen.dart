import 'package:flutter/material.dart';
import 'carts.dart'; // នាំចូល file Cart របស់អ្នក

class PizzaItem {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const PizzaItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class PizzaListScreen extends StatelessWidget {
  const PizzaListScreen({super.key});

  final List<PizzaItem> pizzas = const [
    PizzaItem(
      name: 'Cheese Pizza',
      description: 'Loaded with extra mozzarella cheese.',
      price: 8.50,
      imageUrl: 'https://images.unsplash.com/photo-1548369937-47519962c11a?w=500',
    ),
    PizzaItem(
      name: 'Hot Dog Pizza',
      description: 'Topped with savory hot dog slices and special sauce.',
      price: 9.50,
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
    ),
    PizzaItem(
      name: 'Pepperoni Supreme',
      description: 'Packed with double pepperoni and rich tomato sauce.',
      price: 10.00,
      imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=500',
    ),
    PizzaItem(
      name: 'Seafood Deluxe',
      description: 'Shrimp, squid, and crab sticks with garlic butter.',
      price: 11.50,
      imageUrl: 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=500',
    ),
    PizzaItem(
      name: 'BBQ Chicken Pizza',
      description: 'Grilled chicken, onions, and smoky BBQ sauce.',
      price: 9.75,
      imageUrl: 'https://images.unsplash.com/photo-1590947132387-155cc02f3212?w=500',
    ),
    PizzaItem(
      name: 'Hawaiian Paradise',
      description: 'Sweet pineapple chunks, ham, and extra cheese.',
      price: 9.00,
      imageUrl: 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=500',
    ),
    // 🍕 បន្ថែមភីហ្សាថ្មីៗចំនួន ៤ មុខទៀតនៅទីនេះ
    PizzaItem(
      name: 'Mushroom Truffle Pizza',
      description: 'Earthy mushrooms drizzled with rich truffle oil and mozzarella.',
      price: 10.50,
      imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500',
    ),
    PizzaItem(
      name: 'Spicy Veggie Pizza',
      description: 'Bell peppers, onions, jalapenos, and spicy tomato base.',
      price: 8.25,
      imageUrl: 'https://images.unsplash.com/photo-1593560708920-61dd98c46a4e?w=500',
    ),
    PizzaItem(
      name: 'Four Cheese Feast',
      description: 'Mozzarella, parmesan, gorgonzola, and cheddar blend.',
      price: 11.00,
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
    ),
    PizzaItem(
      name: 'Meat Lovers Pizza',
      description: 'Loaded with beef, bacon, sausage, and pepperoni.',
      price: 12.00,
      imageUrl: 'https://images.unsplash.com/photo-1534308983496-4fabb1a015ee?w=500',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍕 Pizza Menu'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final pizza = pizzas[index];
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
                    pizza.imageUrl,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                // 📝 បង្ហាញព័ត៌មានភីហ្សា
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pizza.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        pizza.description,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '\$${pizza.price.toStringAsFixed(2)}',
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
                        title: pizza.name,
                        subtitle: 'Pizza Restaurant',
                        price: pizza.price,
                        quantity: 1,
                        imageUrl: pizza.imageUrl,
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