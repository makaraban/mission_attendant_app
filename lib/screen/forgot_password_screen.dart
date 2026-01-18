import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() async {
    if (_emailController.text.isEmpty) {
      _showSnackBar('Please enter your email address');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
      _showSnackBar('Please enter a valid email address');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            SizedBox(width: 10),
            Text('Email Sent'),
          ],
        ),
        content: const Text('Password reset link has been sent to your email.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back Button
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Title
                    Text(
                      'Forgot Password',
                      style: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        // color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      'Enter your email address to receive a reset link and\nregain access to your account.',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        // color: const Color(0xFF666666),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Email Address Field
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email address',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              // color: const Color(0xFFE5E5E5),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Icon(
                                  Icons.email_outlined,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      left: 8,
                                      right: 16,
                                      top: 18,
                                      bottom: 18,
                                    ),
                                    hintText: 'Enter your email address',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF999999),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleContinue,
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: Colors.blue,
                          // foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                            : Text(
                          'Continue',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),

              // Custom Keyboard
              _buildCustomKeyboard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomKeyboard() {
    return Container(
      // color: Colors.grey[100],
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Row 1: qwertyuiop
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 'qwertyuiop'.split('').map((char) {
              return _buildKeyboardKey(char);
            }).toList(),
          ),

          const SizedBox(height: 8),

          // Row 2: asdfghjkl
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 'asdfghjkl'.split('').map((char) {
              return _buildKeyboardKey(char);
            }).toList(),
          ),

          const SizedBox(height: 8),

          // Row 3: dzxcvbnm (Note: 'd' at beginning as shown in your description)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: 'dzxcvbnm'.split('').map((char) {
              return _buildKeyboardKey(char);
            }).toList(),
          ),

          const SizedBox(height: 8),

          // Row 4: Special keys
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 123 Key
              _buildSpecialKey('123'),
              const SizedBox(width: 8),

              // Space Key
              Expanded(
                child: _buildSpecialKey('space'),
              ),
              const SizedBox(width: 8),

              // Return Key
              _buildSpecialKey('return'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardKey(String char) {
    return Container(
      width: 36,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            _emailController.text += char;
          },
          child: Center(
            child: Text(
              char.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialKey(String label) {
    Widget content;

    switch (label) {
      case '123':
        content = Text(
          '123',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        );
        break;
      case 'space':
        content = Text(
          'space',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        );
        break;
      case 'return':
        content = Text(
          'return',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        );
        break;
      default:
        content = const SizedBox();
    }

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            switch (label) {
              case '123':
              // Switch to number keyboard (not implemented)
                _showSnackBar('Number keyboard (not implemented)');
                break;
              case 'space':
                _emailController.text += ' ';
                break;
              case 'return':
                _handleContinue();
                break;
            }
          },
          child: Center(child: content),
        ),
      ),
    );
  }
}