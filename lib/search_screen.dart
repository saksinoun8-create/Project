import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodItem {
  final String title;
  final String restaurant;
  final String category;
  final String imageUrl;

  FoodItem({
    required this.title,
    required this.restaurant,
    required this.category,
    required this.imageUrl,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      title: json['title'] ?? '',
      restaurant: json['restaurant'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
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
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchFoodData();
  }

  // Function ទាញយកទិន្នន័យពី API
  Future<void> _fetchFoodData() async {
    // ជំនួស URL នេះជាមួយ Mock API Endpoint របស់អ្នក
    final url = Uri.parse('https://mocki.io/v1/your-endpoint-id');

    try {
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
        setState(() {
          _errorMessage = 'បរាជ័យក្នុងការទាញយកទិន្នន័យ: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'មានបញ្ហាក្នុងការភ្ជាប់បណ្តាញ: $e';
        _isLoading = false;
      });
    }
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

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                setState(() => _isLoading = true);
                _fetchFoodData();
              },
              child: const Text('ព្យាយាមម្តងទៀត'),
            ),
          ],
        ),
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('ជ្រើសរើស: ${item.title}')),
            );
          },
        );
      },
    );
  }
}