import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'burger_list_screen.dart';
import 'pizza_list_screen.dart';
import 'asian_list_screen.dart';
import 'drink_list_screen.dart';
import 'dessert_list_screen.dart';
import 'groceries_list_screen.dart';
import 'carts.dart';

class FoodItem {
  final String title;
  final String restaurant;
  final String category;
  final String imageUrl;
  final double price;

  FoodItem({
    required this.title,
    required this.restaurant,
    required this.category,
    required this.imageUrl,
    this.price = 5.00, // តម្លៃលំនាំដើម
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      title: json['title'] ?? '',
      restaurant: json['restaurant'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : 5.00,
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FoodItem> _allItems = [];
  List<FoodItem> _filteredItems = [];
  bool _isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _fetchFoodData();
  }

  // 🌐 មុខងារទាញយកទិន្នន័យពី API (ឬប្រើ Mock Data ប្រសិនបើ API មិនទាន់មាន)
  Future<void> _fetchFoodData() async {
    try {
      // ជំនួស URL របស់អ្នកនៅទីនេះ ឬប្រើប្រាស់ទិន្នន័យគំរូខាងក្រោមប្រសិនបើគ្មាន API ពិតប្រាកដ
      final url = Uri.parse('https://mocki.io/v1/your-endpoint-id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final foods = data.map((item) => FoodItem.fromJson(item)).toList();

        setState(() {
          _allItems = foods;
          _filteredItems = foods;
          _isLoading = false;
        });
      } else {
        _loadMockData(); // បើ API error គឺទាញយក Mock Data ជំនួសដើម្បីឱ្យ App ដើរទាន់ចិត្ត
      }
    } catch (e) {
      _loadMockData(); // បើមានបញ្ហាអ៊ិនធឺណិត គឺប្រើប្រាស់ Mock Data ជំនួស
    }
  }

  // 📦 ទិន្នន័យគំរូ (Mock Data) សម្រាប់តេស្តក្នុង App
  void _loadMockData() {
    final mockList = [
      FoodItem(
        title: 'Classic Cheeseburger',
        restaurant: 'Burger Lab',
        category: 'Burgers',
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500',
        price: 4.50,
      ),
      FoodItem(
        title: 'Margherita Pizza',
        restaurant: 'Bella Napoli',
        category: 'Pizza',
        imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500',
        price: 8.50,
      ),
      FoodItem(
        title: 'Tonkotsu Ramen',
        restaurant: 'Tokyo Ramen Bar',
        category: 'Asian',
        imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
        price: 6.50,
      ),
      FoodItem(
        title: 'Bubble Milk Tea',
        restaurant: 'Koi Thé',
        category: 'Drinks',
        imageUrl: 'https://images.unsplash.com/photo-1541658016709-82535e94bc69?w=500',
        price: 3.00,
      ),
    ];

    setState(() {
      _allItems = mockList;
      _filteredItems = mockList;
      _isLoading = false;
    });
  }

  void _filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = _allItems;
      } else {
        _filteredItems = _allItems
            .where((item) =>
                item.title.toLowerCase().contains(query.toLowerCase()) ||
                item.restaurant.toLowerCase().contains(query.toLowerCase()) ||
                item.category.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandPink = Color(0xFFD70F64);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: brandPink,
        elevation: 0,
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(21),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _filterSearch,
            decoration: const InputDecoration(
              hintText: 'ស្វែងរកម្ហូប ឬហាង...',
              hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
              prefixIcon: Icon(Icons.search, color: brandPink),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
      ),
      body: _buildBody(brandPink),
    );
  }

  Widget _buildBody(Color brandPink) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(color: brandPink),
      );
    }

    if (_filteredItems.isEmpty) {
      return const Center(child: Text('មិនមានទិន្នន័យស្វែងរកឡើយ'));
    }

    return ListView.separated(
      itemCount: _filteredItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1, indent: 76),
      itemBuilder: (context, index) {
        final item = _filteredItems[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 50,
                height: 50,
                color: const Color(0xFFFFE8E8),
                child: const Icon(Icons.fastfood, color: Color(0xFFD70F64)),
              ),
            ),
          ),
          title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text('${item.restaurant} • ${item.category}'),
          trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.black38),
          onTap: () {
            // 🛒 1. បន្ថែមចូលក្នុងកន្ត្រកដោយស្វ័យប្រវត្តិ
            globalCartItems.add(
              CartItemModel(
                title: item.title,
                subtitle: item.restaurant,
                price: item.price,
                quantity: 1,
                imageUrl: item.imageUrl,
              ),
            );

            // 🚀 2. រុញទៅកាន់ទំព័ររៀងៗខ្លួនតាម Category
            Widget targetScreen = const BurgerListScreen(); // គំរูลំនាំដើម

            if (item.category.toLowerCase().contains('burger')) {
              targetScreen = const BurgerListScreen();
            } else if (item.category.toLowerCase().contains('pizza')) {
              targetScreen = const PizzaListScreen();
            } else if (item.category.toLowerCase().contains('asian')) {
              targetScreen = const AsianListScreen();
            } else if (item.category.toLowerCase().contains('drink')) {
              targetScreen = const DrinkListScreen();
            } else if (item.category.toLowerCase().contains('dessert')) {
              targetScreen = const DessertListScreen();
            } else if (item.category.toLowerCase().contains('grocery')) {
              targetScreen = const GroceriesListScreen();
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => targetScreen),
            );
          },
        );
      },
    );
  }
}