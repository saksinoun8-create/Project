import 'package:flutter/material.dart';
import 'order_history_screen.dart'; // 👈 នាំចូលទំព័រប្រវត្តិនៃការបញ្ជាទិញ
import 'change_password.dart'; // នាំចូលទំព័រផ្លាស់ប្តូរពាក្យសម្ងាត់ (បើមាន)

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ================= 1. pandaPay & Points =================
          GestureDetector(
            onTap: () {
              _showInfoDialog(context, 'pandaPay & Points', 'សមតុល្យ: \$25.00 • 120 ពិន្ទុ');
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD70F64),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.payment, color: Colors.white, size: 28),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'pandaPay & Points',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'សមតុល្យ: \$25.00 • 120 ពិន្ទុ',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // ================= 2. បញ្ជីម៉ឺនុយផ្សេងៗ =================
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
            ),
            child: Column(
              children: [
                // 🛒 ការបញ្ជាទិញ & ការកម្ម៉ង់ម្ដងទៀត (ភ្ជាប់ទៅកាន់ OrderHistoryScreen)
                ListTile(
                  leading: const Icon(Icons.receipt_long, color: Color(0xFFD70F64)),
                  title: const Text('ការបញ្ជាទិញ & ការកម្ម៉ង់ម្ដងទៀត'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    // 🚀 រុញទៅកាន់ទំព័រ OrderHistoryScreen យ៉ាងត្រឹមត្រូវ
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderHistoryScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),

                // កែប្រែព័ត៌មានផ្ទាល់ខ្លួន
                ListTile(
                  leading: const Icon(Icons.person_outline, color: Color(0xFFD70F64)),
                  title: const Text('កែប្រែព័ត៌មានផ្ទាល់ខ្លួន'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    _showInfoDialog(context, 'ព័ត៌មានផ្ទាល់ខ្លួន', 'ឈ្មោះ: Dara • អ៊ីមែល: dara@gmail.com');
                  },
                ),
                const Divider(height: 1),

                // អាសយដ្ឋានដែលបានរក្សាទុក
                ListTile(
                  leading: const Icon(Icons.location_on_outlined, color: Color(0xFFD70F64)),
                  title: const Text('អាសយដ្ឋានដែលបានរក្សាទុក'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    _showInfoDialog(context, 'អាសយដ្ឋាន', 'Preaek Lieb, Phnom Penh');
                  },
                ),
                const Divider(height: 1),

                // វិធីសាស្ត្រទូទាត់ប្រាក់
                ListTile(
                  leading: const Icon(Icons.credit_card, color: Color(0xFFD70F64)),
                  title: const Text('វិធីសាស្ត្រទូទាត់ប្រាក់'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    _showInfoDialog(context, 'ការទូទាត់', 'ABA Pay, Cash on Delivery');
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ================= 3. ផ្នែកសុវត្ថិភាព និងជំនួយ =================
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1))],
            ),
            child: Column(
              children: [
                // ប្តូរពាក្យសម្ងាត់ (Change Password)
                ListTile(
                  leading: const Icon(Icons.lock_outline, color: Color(0xFFD70F64)),
                  title: const Text('ប្តូរពាក្យសម្ងាត់ (Change Password)'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),

                // មជ្ឈមណ្ឌលជំនួយ (Help Center)
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Color(0xFFD70F64)),
                  title: const Text('មជ្ឈមណ្ឌលជំនួយ (Help Center)'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    _showInfoDialog(context, 'Help Center', 'សូមទាក់ទងមកកាន់ 012 345 678 សម្រាប់ជំនួយបន្ថែម។');
                  },
                ),
                const Divider(height: 1),

                // អំពី foodpanda
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Color(0xFFD70F64)),
                  title: const Text('អំពី foodpanda'),
                  subtitle: const Text('Version 2.4.0', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () {
                    _showInfoDialog(context, 'About foodpanda', 'Foodpanda App Version 2.4.0 \nDeveloped with Flutter.');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🛠️ មុខងារជំនួយសម្រាប់បង្ហាញ Dialog ព័ត៌មានផ្សេងៗ
  void _showInfoDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD70F64),
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('បិទ'),
            ),
          ],
        );
      },
    );
  }
}