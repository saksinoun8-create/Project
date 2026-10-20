// 📦 ថ្នាក់គំរូសម្រាប់ប្រវត្តិការបញ្ជាទិញ
class OrderHistoryModel {
  final String orderId;
  final String foodName;
  final String price;
  final String status;

  OrderHistoryModel({
    required this.orderId,
    required this.foodName,
    required this.price,
    required this.status,
  });
}

// 🌐 Global List កណ្តាលសម្រាប់រក្សាទុកប្រវត្តិបញ្ជាទិញទាំងអស់
List<OrderHistoryModel> globalOrderHistory = [
  OrderHistoryModel(
    orderId: '98452',
    foodName: 'Classic Cheeseburger',
    price: '\$16.50',
    status: 'បានដឹកជញ្ជូនរួចរាល់',
  ),
];