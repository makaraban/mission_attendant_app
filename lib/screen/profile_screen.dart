import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mission_attendant_app/screen/my_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // final theme = _isDarkMode ? _darkTheme : _lightTheme;

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Time
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 16),
              //   child: Text(
              //     '9:41',
              //     style: GoogleFonts.inter(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w600,
              //       // color: theme.textTheme.bodyLarge?.color?.withOpacity(0.7),
              //     ),
              //   ),
              // ),

              // Title
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 24),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Profile',
              //       style: GoogleFonts.inter(
              //         fontSize: 32,
              //         fontWeight: FontWeight.w700,
              //         // color: theme.textTheme.headlineMedium?.color,
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 32),

              // Profile Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    // color: theme.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: _isDarkMode ? [] : [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.1),
                    //     blurRadius: 20,
                    //     offset: const Offset(0, 4),
                    //   ),
                    // ],
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.blue, Colors.lightBlue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 20),

                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BAN MAKARA',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                // color: theme.textTheme.bodyLarge?.color,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              'makaraban@gmail.com',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                // color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Dark mode toggle
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfileScreen()));
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //     content: Text('Edit profile'),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.blue.withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      'Edit Profile',
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),

                                const Spacer(),

                                // // Dark mode toggle
                                // Switch(
                                //   value: _isDarkMode,
                                //   onChanged: (value) {
                                //     setState(() {
                                //       _isDarkMode = value;
                                //     });
                                //   },
                                //   activeColor: Colors.blue,
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildMenuTile(
                      icon: Icons.person_outline,
                      title: 'My Profile',
                      // theme: theme,
                    ),
                    _buildMenuTile(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      // theme: theme,
                    ),
                    _buildMenuTile(
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      // theme: theme,
                    ),
                    _buildMenuTile(
                      icon: Icons.history_outlined,
                      title: 'Transaction History',
                      // theme: theme,
                    ),
                    _buildMenuTile(
                      icon: Icons.help_outline_outlined,
                      title: 'FAQ',
                      // theme: theme,
                    ),
                    _buildMenuTile(
                      icon: Icons.info_outline,
                      title: 'About App',
                      // theme: theme,
                    ),
                    _buildMenuTile(
                      icon: Icons.logout_outlined,
                      title: 'Logout',
                      // theme: theme,
                      isLogout: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    // required ThemeData theme,
    bool isLogout = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isLogout) {
              _showLogoutDialog();
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              // color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                // color: theme.dividerColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  // color: isLogout ? Colors.red : theme.iconTheme.color,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      // color: isLogout ? Colors.red : theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  // color: theme.iconTheme.color?.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  // final ThemeData _lightTheme = ThemeData.light().copyWith(
  //   scaffoldBackgroundColor: Colors.white,
  //   cardColor: Colors.white,
  //   dividerColor: Colors.grey[300],
  //   iconTheme: const IconThemeData(color: Colors.black),
  // );
  //
  // final ThemeData _darkTheme = ThemeData.dark().copyWith(
  //   scaffoldBackgroundColor: const Color(0xFF121212),
  //   cardColor: const Color(0xFF1E1E1E),
  //   dividerColor: Colors.grey[800],
  //   iconTheme: const IconThemeData(color: Colors.white),
  // );
}