
import 'package:flutter/material.dart';
import 'categories.dart';

class Restaurant {
  final String id;
  final String name;
  final String categoryId;
  final double rating;
  final String deliveryTime;
  final String deliveryFee;

  const Restaurant({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.rating,
    required this.deliveryTime,
    required this.deliveryFee,
  });
}

class RestaurantListScreen extends StatelessWidget {
  final CategoryItem category;

  const RestaurantListScreen({
    super.key,
    required this.category,
  });

  // Mock restaurant data
  static const List<Restaurant> allRestaurants = [
    Restaurant(
      id: 'r1',
      name: 'Burger Lab',
      categoryId: 'c1',
      rating: 4.6,
      deliveryTime: '20-30 min',
      deliveryFee: '\$1.50',
    ),
    Restaurant(
      id: 'r2',
      name: 'Smash & Shake',
      categoryId: 'c1',
      rating: 4.8,
      deliveryTime: '25-35 min',
      deliveryFee: '\$0.99',
    ),
    Restaurant(
      id: 'r3',
      name: 'Bella Napoli Pizza',
      categoryId: 'c2',
      rating: 4.7,
      deliveryTime: '30-40 min',
      deliveryFee: 'Free',
    ),
    Restaurant(
      id: 'r4',
      name: 'Tokyo Ramen Bar',
      categoryId: 'c3',
      rating: 4.9,
      deliveryTime: '15-25 min',
      deliveryFee: '\$2.00',
    ),
    Restaurant(
      id: 'r5',
      name: 'Sweet Tooth Bakery',
      categoryId: 'c4',
      rating: 4.5,
      deliveryTime: '20-30 min',
      deliveryFee: '\$1.00',
    ),
    Restaurant(
      id: 'r6',
      name: 'Panda Mart Express',
      categoryId: 'c6',
      rating: 4.4,
      deliveryTime: '15-20 min',
      deliveryFee: 'Free',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter restaurants matching the selected category ID
    final filteredRestaurants = allRestaurants
        .where((restaurant) => restaurant.categoryId == category.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: const Color(0xFFD70F64),
        foregroundColor: Colors.white,
      ),
      body: filteredRestaurants.isEmpty
          ? Center(
              child: Text(
                'No restaurants found for ${category.title}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: filteredRestaurants.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: category.color,
                      child: Icon(category.icon, color: const Color(0xFFD70F64)),
                    ),
                    title: Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text('${restaurant.rating} • '),
                          Text('${restaurant.deliveryTime} • '),
                          Text(restaurant.deliveryFee),
                        ],
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => RestaurantListScreen(category: category),
                       ),
                      );
                    },
                  
                  ),
                );
              },
            ),
    );
  }
}