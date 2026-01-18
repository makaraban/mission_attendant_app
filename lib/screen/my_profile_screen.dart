import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String _selectedGender = 'Male';
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Profile',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '9:41',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Basic Detail Section
            _buildSection('Basic Detail'),

            const SizedBox(height: 24),

            // Full name
            _buildFieldLabel('Full name'),
            const SizedBox(height: 8),
            _buildField(
              initialValue: 'Bagia Alfatih',
              hintText: 'Enter full name',
            ),

            const SizedBox(height: 20),

            // Date of birth
            _buildFieldLabel('Date of birth'),
            const SizedBox(height: 8),
            _buildField(
              initialValue: '7 July 2002',
              hintText: 'Select date',
              isDatePicker: true,
            ),

            const SizedBox(height: 20),

            // Gender
            _buildFieldLabel('Gender'),
            const SizedBox(height: 8),
            _buildGenderSelector(),

            const SizedBox(height: 40),

            // Contact Detail Section
            _buildSection('Contact Detail'),

            const SizedBox(height: 24),

            // Mobile number
            _buildFieldLabel('Mobile number'),
            const SizedBox(height: 8),
            _buildField(
              initialValue: '',
              hintText: 'Enter mobile number',
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile saved successfully'),
                backgroundColor: Colors.green,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Save',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildField({
    required String initialValue,
    required String hintText,
    bool isDatePicker = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              initialValue: initialValue,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          if (isDatePicker)
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildGenderChip(
            label: 'Male',
            isSelected: _selectedGender == 'Male',
            onTap: () {
              setState(() {
                _selectedGender = 'Male';
              });
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildGenderChip(
            label: 'Female',
            isSelected: _selectedGender == 'Female',
            onTap: () {
              setState(() {
                _selectedGender = 'Female';
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Colors.blue : Colors.grey[400],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}