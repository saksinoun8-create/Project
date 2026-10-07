import 'package:flutter/material.dart';
import 'main.dart'; // Import ដើម្បីហៅ LoginScreen

// ពណ៌សំខាន់ៗរបស់ foodpanda
const Color kFoodpandaPink = Color(0xFFD70F64);
const Color kTextPrimary = Color(0xFF333333);
const Color kTextSecondary = Color(0xFF707070);

class LogoutHelper {
  /// បង្ហាញ Dialog បញ្ជាក់មុនពេលចាកចេញ (Confirm Logout)
  static Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  color: Color(0xFFFDE8EF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text('🐼', style: TextStyle(fontSize: 32)),
              ),
              const SizedBox(height: 18),
              const Text(
                'ចាកចេញពី foodpanda?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: kTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'តើអ្នកពិតជាចង់ចាកចេញពីគណនីនេះមែនទេ?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: kTextSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            Row(
              children: [
                // ប៊ូតុងបោះបង់ (Cancel)
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'បោះបង់',
                      style: TextStyle(
                        color: kTextSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // ប៊ូតុងចាកចេញ (Logout)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(dialogContext).pop(); // បិទ Dialog
                      await _executeLogout(context);      // ដំណើរការចាកចេញ
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kFoodpandaPink,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'ចាកចេញ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  /// សម្អាតទិន្នន័យ Session រួចប្ដូរទៅកាន់ LoginScreen
  static Future<void> _executeLogout(BuildContext context) async {
    // បើមានប្រើ Local Storage ឬ Firebase អាច clear នៅទីនេះបាន៖
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    if (!context.mounted) return;

    // លុប navigation stack ទាំងអស់ចោល រួចបើក LoginScreen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}