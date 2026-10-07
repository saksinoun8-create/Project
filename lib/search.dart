import 'package:flutter/material.dart';

class FoodItem {
  final String title;
  final String restaurant;
  final String category;
  final String imageUrl;

  const FoodItem({
    required this.title,
    required this.restaurant,
    required this.category,
    required this.imageUrl,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // បញ្ជីទិន្នន័យដើម
  final List<FoodItem> _allItems = const [
    FoodItem(
      title: 'Classic Cheeseburger',
      restaurant: 'Burger Lab',
      category: 'Burgers',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200',
    ),
    FoodItem(
      title: 'Double Beef Burger',
      restaurant: 'Smash & Shake',
      category: 'Burgers',
      imageUrl: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=200',
    ),
    FoodItem(
      title: 'Margherita Pizza',
      restaurant: 'Bella Napoli',
      category: 'Pizza',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200',
    ),
    FoodItem(
      title: 'Pepperoni Feast',
      restaurant: 'Pizza Company',
      category: 'Pizza',
      imageUrl: 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=200',
    ),
    FoodItem(
      title: 'Tonkotsu Ramen',
      restaurant: 'Tokyo Ramen Bar',
      category: 'Asian',
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=200',
    ),
    FoodItem(
      title: 'Bubble Milk Tea',
      restaurant: 'Koi Thé',
      category: 'Drinks',
      imageUrl: 'https://images.unsplash.com/photo-1558857563-b37cf05d8a58?w=200',
    ),
    FoodItem(
      title: 'Chocolate Brownie',
      restaurant: 'Sweet Tooth',
      category: 'Desserts',
      imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=200',
    ),
  ];

  // បញ្ជីទិន្នន័យដែល Filter រួច
  List<FoodItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
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
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _filterSearch,
            decoration: const InputDecoration(
              hintText: 'ស្វែងរកម្ហូប ឬហាង...',
              hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
              prefixIcon: Icon(Icons.search, color: brandPink),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 11),
            ),
          ),
        ),
      ),
      body: _filteredItems.isEmpty
          ? const Center(
              child: Text(
                'មិនមានទិន្នន័យស្វែងរកឡើយ',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.separated(
              itemCount: _filteredItems.length,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 76),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 50,
                        height: 50,
                        color: const Color(0xFFFFE8E8),
                        child: const Icon(Icons.fastfood, color: brandPink),
                      ),
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  subtitle: Text(
                    '${item.restaurant} • ${item.category}',
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.black38, size: 20),
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ជ្រើសរើស: ${item.title}'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}