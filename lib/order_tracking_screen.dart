import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        title: const Text(
          'តាមដានការដឹកជញ្ជូន (Order Tracking)',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: const Color(0xFFD70F64), // Foodpanda Pink
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ស្ថានភាពការបញ្ជាទិញ
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'អត្តសញ្ញាណប័ណ្ណបញ្ជាទិញ: #$orderId',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const Text(
                        'ប៉ាន់ស្មាន៖ ២០ នាទី',
                        style: TextStyle(
                          color: Color(0xFFD70F64),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  const _TrackingStep(
                    title: 'ការបញ្ជាទិញបានសម្រេច',
                    subtitle: 'ហាងបានទទួលការបញ្ជាទិញរបស់អ្នកហើយ',
                    isCompleted: true,
                    isCurrent: false,
                  ),
                  const _TrackingStep(
                    title: 'កំពុងរៀបចំម្ហូប',
                    subtitle: 'Chef កំពុងចម្អិនម្ហូបរបស់អ្នកយ៉ាងយកចិត្តទុកដាក់',
                    isCompleted: true,
                    isCurrent: true,
                  ),
                  const _TrackingStep(
                    title: 'អ្នកដឹកជញ្ជូនកំពុងយកម្ហូប',
                    subtitle: 'បុគ្គលិកដឹកជញ្ជូនកំពុងធ្វើដំណើរទៅកាន់ទីតាំងហាង',
                    isCompleted: false,
                    isCurrent: false,
                  ),
                  const _TrackingStep(
                    title: 'បានដឹកជញ្ជូនដល់គោលដៅ',
                    subtitle: 'រីករាយជាមួយអាហាររបស់អ្នក!',
                    isCompleted: false,
                    isCurrent: false,
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ព័ត៌មានអ្នកដឹកជញ្ជូន (Driver Info)
            const Text(
              'ព័ត៌មានអ្នកដឹកជញ្ជូន',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
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
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          'Honda Dream (1234 - PP)',
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // សកម្មភាពសម្រាប់ទាក់ទងទៅអ្នកដឹកជញ្ជូន
                    },
                    icon: const Icon(Icons.phone, color: Color(0xFFD70F64)),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // ប៊ូតុងត្រឡប់ទៅទំព័រដើម
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD70F64),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // ត្រឡប់ទៅកាន់ទំព័រដើមបង្អស់ (Root Page)
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text(
                  'ត្រឡប់ទៅទំព័រដើម (Back to Home)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget ជំនួយសម្រាប់បង្ហាញជំហាននីមួយៗនៃការដឹកជញ្ជូន
class _TrackingStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  const _TrackingStep({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isCurrent,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    Color color = isCompleted || isCurrent
        ? const Color(0xFFD70F64)
        : Colors.grey.shade400;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? const Color(0xFFD70F64) : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 2),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : isCurrent
                      ? Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD70F64),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted
                    ? const Color(0xFFD70F64)
                    : Colors.grey.shade300,
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
                  color: isCurrent ? const Color(0xFFD70F64) : Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}