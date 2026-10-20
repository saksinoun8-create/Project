import 'dart:async';
import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  // ⏱️ រាប់ថយក្រោយជាវិនាទី (ឧទាហរណ៍៖ ២០ វិនាទី)
  int _remainingSeconds = 20;
  Timer? _timer;

  // 📊 កម្រិតស្ថានភាពនៃការបញ្ជាទិញ (currentIndex ពី 0 ដល់ 3)
  // 0: បានបញ្ជាទិញរួចរាល់
  // 1: កំពុងរៀបចំម្ហូប
  // 2: អ្នកដឹកជញ្ជូនកំពុងយកម្ហូប
  // 3: បានដឹកជញ្ជូនដល់គោលដៅ
  int _currentStep = 1;

  @override
  void initState() {
    super.initState();
    _startOrderTimer();
  }

  // 🚀 មុខងារដំណើរការ Timer ប្តូរដំណាក់កាលដោយខ្លួនឯង
  void _startOrderTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;

          // 🔄 ប្តូរ step តាមពេលវេលាដែលនៅសល់
          if (_remainingSeconds == 15) {
            _currentStep = 1; // កំពុងរៀបចំម្ហូប
          } else if (_remainingSeconds == 8) {
            _currentStep = 2; // អ្នកដឹកជញ្ជូនកំពុងយកម្ហូប
          } else if (_remainingSeconds == 2) {
            _currentStep = 3; // បានដឹកជញ្ជូនដល់គោលដៅ
          }
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // បញ្ឈប់ Timer កدាលបិទ Screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('តាមដានការដឹកជញ្ជូន (Order Tracking)'),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= 1. Card បង្ហាញស្ថានភាព =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'អត្តសញ្ញាណប័ណ្ណបញ្ជាទិញ: #${widget.orderId}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        _remainingSeconds > 0
                            ? 'ប៉ាន់ស្មាន៖ $_remainingSeconds នាទី'
                            : 'ម្ហូបបានទៅដល់ហើយ!',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFD70F64)),
                      ),
                    ],
                  ),
                  const Divider(height: 24),

                  // Step 1: ការបញ្ជាទិញបានសម្រេច
                  _buildTrackingStep(
                    title: 'ការបញ្ជាទិញបានសម្រេច',
                    subtitle: 'ហាងបានទទួលការបញ្ជាទិញរបស់អ្នកហើយ',
                    isCompleted: true,
                    isCurrent: false,
                  ),

                  // Step 2: កំពុងរៀបចំម្ហូប
                  _buildTrackingStep(
                    title: 'កំពុងរៀបចំម្ហូប',
                    subtitle: 'Chef កំពុងចម្អិនម្ហូបរបស់អ្នកយ៉ាងយកចិត្តទុកដាក់',
                    isCompleted: _currentStep > 1,
                    isCurrent: _currentStep == 1,
                  ),

                  // Step 3: អ្នកដឹកជញ្ជូនកំពុងយកម្ហូប
                  _buildTrackingStep(
                    title: 'អ្នកដឹកជញ្ជូនកំពុងយកម្ហូប',
                    subtitle: 'បុគ្គលិកដឹកជញ្ជូនកំពុងធ្វើដំណើរទៅកាន់ទីតាំងហាង',
                    isCompleted: _currentStep > 2,
                    isCurrent: _currentStep == 2,
                  ),

                  // Step 4: បានដឹកជញ្ជូនដល់គោលដៅ
                  _buildTrackingStep(
                    title: 'បានដឹកជញ្ជូនដល់គោលដៅ',
                    subtitle: 'រីករាយជាមួយអាហាររបស់អ្នក!',
                    isCompleted: _currentStep >= 3,
                    isCurrent: _currentStep == 3,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ================= 2. ព័ត៌មានអ្នកដឹកជញ្ជូន =================
            const Text(
              'ព័ត៌មានអ្នកដឹកជញ្ជូន',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundColor: Color(0xFFD70F64),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'សុខា (Sokha)',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Honda Dream (1234 - PP)',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // 📞 មុខងារខលទៅអ្នកដឹក
                    },
                    icon: const Icon(Icons.phone, color: Color(0xFFD70F64)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // ================= 3. ប៊ូតុងត្រឡប់ទៅទំព័រដើម =================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD70F64),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // 🏠 ត្រឡប់ទៅទំព័រដើមវិញ (Pop រហូតដល់ Root)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'ត្រឡប់ទៅទំព័រដើម (Back to Home)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🛠️ Widget ជំនួយសម្រាប់បង្កើតនីតិវិធីនីមួយៗ (Step)
  Widget _buildTrackingStep({
    required String title,
    required String subtitle,
    required bool isCompleted,
    required bool isCurrent,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted || isCurrent ? const Color(0xFFD70F64) : Colors.grey.shade300,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : isCurrent
                        ? const Icon(Icons.circle, size: 10, color: Colors.white)
                        : const SizedBox(),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? const Color(0xFFD70F64) : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: isCompleted || isCurrent ? Colors.black87 : Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}