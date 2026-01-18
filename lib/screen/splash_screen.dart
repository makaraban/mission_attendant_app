import 'package:flutter/material.dart';
import 'package:mission_attendant_app/screen/home_screen.dart';
import 'package:mission_attendant_app/screen/main_screen.dart';
import 'widgets/my_error.dart';
import 'logics/theme_logic.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  Future? _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _loadData();
  }

  Future _loadData() async {
    await Future.delayed(Duration(seconds: 2), () {});
    return Future.any([context.read<ThemeLogic>().readTheme()]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _futureData == null
          ? _buildLogoLoading()
          : FutureBuilder(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return MyError(
              context,
              error: snapshot.error.toString(),
              onPressed: () {
                setState(() {
                  _futureData = _loadData();
                });
              },
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MainScreen();
          } else {
            return _buildLogoLoading();
          }
        },
      ),
    );
  }

  Widget _buildLogoLoading() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Loading..."),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'login_screen.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _textAnimation;
//   late Animation<double> _gradientAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize animations
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     );
//
//     _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.elasticOut,
//       ),
//     );
//
//     _textAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
//       ),
//     );
//
//     _gradientAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     // Start animations
//     _controller.forward();
//
//     // Set up 5-second delay and navigate to login
//     _startTimer();
//   }
//
//   void _startTimer() {
//     Future.delayed(const Duration(seconds: 5), () {
//       // Navigate to login screen after 5 seconds
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient Background
//           AnimatedBuilder(
//             animation: _gradientAnimation,
//             builder: (context, child) {
//               return Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       const Color(0xFF4A6FFF).withOpacity(_gradientAnimation.value),
//                       const Color(0xFF6A5AF9).withOpacity(_gradientAnimation.value),
//                       const Color(0xFF1A237E).withOpacity(_gradientAnimation.value),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Logo with Animation
//                 ScaleTransition(
//                   scale: _logoAnimation,
//                   child: Container(
//                     width: 120,
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.blue.withOpacity(0.5),
//                           blurRadius: 30,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.account_balance_wallet_rounded,
//                       color: Color(0xFF1A237E),
//                       size: 60,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // App Name
//                 FadeTransition(
//                   opacity: _textAnimation,
//                   child: Text(
//                     'AM APP',
//                     style: GoogleFonts.montserrat(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w800,
//                       color: Colors.white,
//                       letterSpacing: 1.5,
//                       shadows: [
//                         const Shadow(
//                           color: Colors.black26,
//                           blurRadius: 10,
//                           offset: Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Tagline
//                 FadeTransition(
//                   opacity: _textAnimation,
//                   child: Text(
//                     'Staff. Management',
//                     style: GoogleFonts.montserrat(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white.withOpacity(0.9),
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 60),
//
//                 // Countdown Timer (Optional)
//                 _buildCountdownTimer(),
//               ],
//             ),
//           ),
//
//           // Loading Indicator at bottom
//           Positioned(
//             bottom: 50,
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 // Loading text
//                 Text(
//                   'Loading...',
//                   style: GoogleFonts.montserrat(
//                     fontSize: 14,
//                     color: Colors.white.withOpacity(0.8),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 // Progress bar
//                 SizedBox(
//                   width: 200,
//                   child: LinearProgressIndicator(
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     valueColor: AlwaysStoppedAnimation<Color>(
//                       Colors.blue.shade200,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCountdownTimer() {
//     return StreamBuilder(
//       stream: Stream.periodic(const Duration(seconds: 1), (i) => i).take(5),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final secondsRemaining = 5 - (snapshot.data as int);
//           return Text(
//             'Starting in $secondsRemaining seconds...',
//             style: GoogleFonts.montserrat(
//               fontSize: 14,
//               color: Colors.white.withOpacity(0.7),
//             ),
//           );
//         }
//         return Container();
//       },
//     );
//   }
// }