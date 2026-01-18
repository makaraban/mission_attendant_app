import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mission_attendant_app/screen/login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() async {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Passwords do not match');
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

    _showSnackBar('Account created successfully!');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.black,
      ),
    );
  }

  void _navigateToLogin() {
    // Navigate to login screen
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // _showSnackBar('Navigating to login screen...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Back Button (Optional)
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),

                const SizedBox(height: 40),

                // Title
                Text(
                  'Create Account',
                  style: GoogleFonts.inter(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    // color: Colors.black,
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'Create a new account to get started and enjoy',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF666666),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 48),

                // Full Name Field
                _buildInputField(
                  label: 'Full Name',
                  controller: _fullNameController,
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                ),

                const SizedBox(height: 20),

                // Email Field
                _buildInputField(
                  label: 'Email',
                  controller: _emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                // Password Field
                _buildInputField(
                  label: 'Password',
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                  isPasswordVisible: _obscurePassword,
                  onTogglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  prefixIcon: Icons.lock_outline,
                ),

                const SizedBox(height: 20),

                // Confirm Password Field
                _buildInputField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  hintText: 'Confirm your password',
                  isPassword: true,
                  isPasswordVisible: _obscureConfirmPassword,
                  onTogglePassword: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                  prefixIcon: Icons.lock_outline,
                ),

                const SizedBox(height: 40),

                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleCreateAccount,
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.blue,
                      // foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
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
                      'Create Account',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Already have account link
                Center(
                  child: GestureDetector(
                    onTap: _navigateToLogin,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              // color: const Color(0xFF666666),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'Sign In here',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              // color: Colors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    IconData? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
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
              color: const Color(0xFFE5E5E5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              if (prefixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Icon(
                    prefixIcon,
                    color: const Color(0xFF999999),
                    size: 20,
                  ),
                ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  obscureText: isPassword && !isPasswordVisible,
                  keyboardType: keyboardType,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.black,
                    letterSpacing: isPassword ? 2 : 0,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      left: prefixIcon != null ? 8 : 16,
                      right: 16,
                      top: 18,
                      bottom: 18,
                    ),
                    hintText: hintText,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      color: const Color(0xFF999999),
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
              if (isPassword && onTogglePassword != null)
                IconButton(
                  icon: Icon(
                    isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF999999),
                  ),
                  onPressed: onTogglePassword,
                ),
            ],
          ),
        ),
      ],
    );
  }
}