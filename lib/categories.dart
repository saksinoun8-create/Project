import 'package:flutter/material.dart';
import 'package:foodpanda_app/burger_list_screen.dart';
import 'package:foodpanda_app/pizza_list_screen.dart'; // នាំចូលไฟล์ PizzaListScreen

class CategoryItem {
  final String id;
  final String title;
  final String imageUrl;
  final Color color;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.color,
  });

  IconData? get icon => null;
}

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // រក្សាទុក id នៃ category ដែលបាន select
  String? _selectedCategoryId;

  static const List<CategoryItem> categories = [
    CategoryItem(
      id: 'c1',
      title: 'Burgers',
      imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
      color: Color(0xFFFFE8E8),
    ),
    CategoryItem(
      id: 'c2',
      title: 'Pizza',
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
      color: Color(0xFFFFF3E0),
    ),
    CategoryItem(
      id: 'c3',
      title: 'Asian',
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=400',
      color: Color(0xFFE8F5E9),
    ),
    CategoryItem(
      id: 'c4',
      title: 'Desserts',
      imageUrl: 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?w=400',
      color: Color(0xFFFCE4EC),
    ),
    CategoryItem(
      id: 'c5',
      title: 'Drinks',
      imageUrl: 'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?w=400',
      color: Color(0xFFE0F7FA),
    ),
    CategoryItem(
      id: 'c6',
      title: 'Groceries',
      imageUrl: 'https://images.unsplash.com/photo-1542838132-92c53300491e?w=400',
      color: Color(0xFFEDE7F6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategoryId == category.id;

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              setState(() {
                _selectedCategoryId = category.id;
              });

              // បើចុចលើ Burgers ឱ្យលោតទៅកាន់ BurgerListScreen
              if (category.title == 'Burgers') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BurgerListScreen(),
                  ),
                );
              } 
              // បើចុចលើ Pizza ឱ្យលោតទៅកាន់ PizzaListScreen
              else if (category.title == 'Pizza') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PizzaListScreen(),
                  ),
                );
              } else {
                // សម្រាប់ Category ផ្សេងៗទៀត បង្ហាញ SnackBar
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Selected: ${category.title}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: category.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFFD70F64) : Colors.black12,
                  width: isSelected ? 3 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFFD70F64).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            category.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const SizedBox(
                                width: 80,
                                height: 80,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Color(0xFFD70F64),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          category.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? const Color(0xFFD70F64) : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isSelected)
                    const Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFD70F64),
                        child: Icon(Icons.check, size: 16, color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}