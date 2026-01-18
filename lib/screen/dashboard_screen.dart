import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF4F7FB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 20),
            _buildMenuSection(),
            const SizedBox(height: 20),
            _buildRecentSection(),
          ],
        ),
      ),
    );
  }

  // 📊 Summary Card
  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _summaryItem(Icons.access_time, "រយៈពេលខ្លី", "12", Colors.green),
          _summaryItem(Icons.flight, "បេសកកម្ម", "5", Colors.blue),
          _summaryItem(
            Icons.calendar_month,
            "ប្រចាំឆ្នាំ",
            "23",
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(IconData icon, String title, String value, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: color,
          ),
        ),
      ],
    );
  }

  // 🗂️ Menu
  Widget _buildMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "សុំច្បាប់",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            _MenuItem(Icons.access_time, "សុំច្បាប់ខ្លី"),
            _MenuItem(Icons.flight, "សុំច្បាប់បេសកកម្ម"),
            _MenuItem(Icons.calendar_month, "សុំច្បាប់ប្រចាំឆ្នាំ"),
          ],
        ),
      ],
    );
  }

  // 📋 Recent
  Widget _buildRecentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "សំណើថ្មីៗ",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        _recentItem("Approved", "15 មករា 2024 - 19 មករា", Colors.green),
        _recentItem("Pending", "15 មករា 2024 - 19 មករា", Colors.orange),
      ],
    );
  }

  Widget _recentItem(String status, String date, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.15),
            child: Icon(
              status == "Approved" ? Icons.check : Icons.access_time,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                Text(date, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

}

// 🔹 Menu Item Widget
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _MenuItem(this.icon, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: Icon(icon, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
