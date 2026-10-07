import 'package:flutter/material.dart';
import 'logouthelper.dart'; // ហៅ LogoutHelper ដែលបានបង្កើតពីមុនមកប្រើ

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Foodpanda Brand Colors
  static const Color kFoodpandaPink = Color(0xFFD70F64);
  static const Color kBackground = Color(0xFFF7F7F7);
  static const Color kTextPrimary = Color(0xFF333333);
  static const Color kTextSecondary = Color(0xFF707070);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        title: const Text(
          'គណនីរបស់ខ្ញុំ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: kTextPrimary,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ផ្នែកព័ត៌មាន User (Header) ព្រមទាំងបញ្ជូន context ចូល
            _buildUserHeader(context),
            const SizedBox(height: 12),

            // ផ្នែក Panda Rewards / Points (ដែលបានបន្ថែមបំពេញវិញ)
            _buildPandaPointsBadge(),
            const SizedBox(height: 12),

            // ក្រុមម៉ឺនុយបញ្ជាទិញ & គណនី (Orders & Account)
            _buildSettingsGroup([
              _SettingsItem(
                icon: Icons.receipt_long_outlined,
                title: 'ការបញ្ជាទិញ & ការកុម្ម៉ង់ឡើងវិញ',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.person_outline,
                title: 'កែប្រែព័ត៌មានផ្ទាល់ខ្លួន',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.location_on_outlined,
                title: 'អាសយដ្ឋានដែលបានរក្សាទុក',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.payment_outlined,
                title: 'វិធីសាស្ត្រទូទាត់ប្រាក់',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 12),

            // ក្រុមជំនួយ & សុវត្ថិភាព (Help & Settings)
            _buildSettingsGroup([
              _SettingsItem(
                icon: Icons.lock_outline,
                title: 'ប្តូរពាក្យសម្ងាត់ (Change Password)',
                onTap: () {
                  // Navigator.push ទៅ ChangePasswordScreen
                },
              ),
              _SettingsItem(
                icon: Icons.help_outline,
                title: 'មជ្ឈមណ្ឌលជំនួយ (Help Center)',
                onTap: () {},
              ),
              _SettingsItem(
                icon: Icons.info_outline,
                title: 'អំពី foodpanda',
                subtitle: 'Version 2.4.0',
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 16),

            // ប៊ូតុងចាកចេញពីគណនី (Logout Button)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => LogoutHelper.showLogoutDialog(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Colors.redAccent, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'ចាកចេញពីគណនី',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // Widget បង្ហាញព័ត៌មាន Profile ខាងលើ (មានដាក់ GestureDetector ត្រឹមត្រូវ)
  Widget _buildUserHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('បានចុចលើព័ត៌មានគណនី Sak Sinuon')),
        );
      },
      child: Container(
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFDE8EF),
                border: Border.all(color: kFoodpandaPink.withValues(alpha: 0.3), width: 2),
              ),
              alignment: Alignment.center,
              child: const Text('🐼', style: TextStyle(fontSize: 32)),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sak Sinuon',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kTextPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'saksinuon@gmail.com',
                    style: TextStyle(fontSize: 13, color: kTextSecondary),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '+855 10356838',
                    style: TextStyle(fontSize: 13, color: kTextSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget បង្ហាញពិន្ទុ/PandaPay (ដែលបានបន្ថែមបំពេញចូលវិញ)
  Widget _buildPandaPointsBadge() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD70F64), Color(0xFFFF5C93)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.wallet, color: Colors.white, size: 28),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'pandaPay & Points',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'សមតុល្យ: \$25.00 • 120 ពិន្ទុ',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  // Helper បង្កើត Group បញ្ជី Items
  Widget _buildSettingsGroup(List<_SettingsItem> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;

          return Column(
            children: [
              ListTile(
                leading: Icon(item.icon, color: kFoodpandaPink, size: 22),
                title: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kTextPrimary,
                  ),
                ),
                subtitle: item.subtitle != null
                    ? Text(
                        item.subtitle!,
                        style: const TextStyle(fontSize: 12, color: kTextSecondary),
                      )
                    : null,
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
                onTap: item.onTap,
              ),
              if (!isLast)
                const Divider(height: 1, indent: 56, endIndent: 16),
            ],
          );
        }),
      ),
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });
}