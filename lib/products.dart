
import 'package:flutter/material.dart';
import 'restaurant_list_screen.dart'; // Import Restaurant model

class Product {
  final String id;
  final String restaurantId;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isPopular;

  const Product({
    required this.id,
    required this.restaurantId,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isPopular = false,
  });
}

class ProductsScreen extends StatelessWidget {
  // Receive the selected restaurant object
  final Restaurant restaurant;

  const ProductsScreen({
    super.key,
    required this.restaurant,
  });

  // Mock catalog of products across various restaurants
  static const List<Product> allProducts = [
    // Burger Lab (r1)
    Product(
      id: 'p1',
      restaurantId: 'r1',
      title: 'Classic Cheeseburger',
      description: 'Juicy beef patty, melted cheddar cheese, fresh lettuce, and house sauce.',
      price: 6.50,
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      isPopular: true,
    ),
    Product(
      id: 'p2',
      restaurantId: 'r1',
      title: 'Loaded Truffle Fries',
      description: 'Crispy skin-on fries drizzled with truffle oil and parmesan.',
      price: 3.75,
      imageUrl: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400',
      isPopular: false,
    ),
    // Smash & Shake (r2)
    Product(
      id: 'p3',
      restaurantId: 'r2',
      title: 'Double Smash Burger',
      description: 'Two smashed patties with caramelized onions and signature sauce.',
      price: 7.99,
      imageUrl: 'https://images.unsplash.com/photo-1625813506062-0aeb1d7a094b?w=400',
      isPopular: true,
    ),
    Product(
      id: 'p4',
      restaurantId: 'r2',
      title: 'Vanilla Thick Shake',
      description: 'Rich and creamy handcrafted vanilla bean milkshake.',
      price: 4.25,
      imageUrl: 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=400',
      isPopular: false,
    ),
    // Bella Napoli Pizza (r3)
    Product(
      id: 'p5',
      restaurantId: 'r3',
      title: 'Margherita Pizza',
      description: 'San Marzano tomatoes, fresh mozzarella, basil, and extra virgin olive oil.',
      price: 11.50,
      imageUrl: 'https://images.unsplash.com/photo-1604382355076-af4b0eb60143?w=400',
      isPopular: true,
    ),
    // Tokyo Ramen Bar (r4)
    Product(
      id: 'p6',
      restaurantId: 'r4',
      title: 'Tonkotsu Ramen',
      description: 'Rich pork broth, chashu pork, soft-boiled egg, and nori.',
      price: 12.00,
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
      isPopular: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const brandPink = Color(0xFFD70F64);

    // Filter products for this specific restaurant
    final restaurantProducts = allProducts
        .where((item) => item.restaurantId == restaurant.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
        backgroundColor: brandPink,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Restaurant info banner header
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Icon(Icons.star, size: 18, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${restaurant.rating}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.timer_outlined, size: 18, color: Colors.black54),
                const SizedBox(width: 4),
                Text(restaurant.deliveryTime),
                const SizedBox(width: 12),
                const Icon(Icons.delivery_dining, size: 18, color: Colors.black54),
                const SizedBox(width: 4),
                Text(restaurant.deliveryFee),
              ],
            ),
          ),

          // Menu list
          Expanded(
            child: restaurantProducts.isEmpty
                ? Center(
                    child: Text(
                      'No menu items found for ${restaurant.name}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: restaurantProducts.length,
                    separatorBuilder: (_, __) => const Divider(height: 24),
                    itemBuilder: (context, index) {
                      final product = restaurantProducts[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (product.isPopular)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 4),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: brandPink.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      'Popular',
                                      style: TextStyle(
                                        color: brandPink,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.imageUrl,
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 90,
                                    height: 90,
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.fastfood, color: Colors.grey),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('${product.title} added to basket!'),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: brandPink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: brandPink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {},
            child: const Text(
              'View Basket',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
// ឧទាហរណ៍សម្រាប់ Cart Item Model
class CartItem {
  final String name;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

// Global List សម្រាប់ងាយស្រួលទាញយកទិន្នន័យដាក់ចូល Cart (ឬអាចប្រើ Provider/State Management)
List<CartItem> myCartList = [];