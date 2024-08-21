// import 'dart:async';
// import 'package:easy_coupon/routes/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _auraAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..repeat(reverse: true);

//     _auraAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );

//     Timer(const Duration(seconds: 4), () {
//       Navigator.pushReplacementNamed(context, RouteNames.introductionAnimation);
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         color: const Color(0xFF294B29), // Set the background color here
//         child: Stack(
//           children: [
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Animated circular aura around the animation
//                   AnimatedBuilder(
//                     animation: _auraAnimation,
//                     builder: (context, child) {
//                       return Container(
//                         width: screenWidth * 0.6 * _auraAnimation.value,
//                         height: screenWidth * 0.6 * _auraAnimation.value,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xFF50623A).withOpacity(0.6),
//                               blurRadius: 50,
//                               spreadRadius: 20,
//                             ),
//                           ],
//                         ),
//                         child: child,
//                       );
//                     },
//                     child: Lottie.asset(
//                       'assets/images/landing/salad.json',
//                       width: screenWidth * 0.5,
//                       height: screenWidth * 0.5,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // Text under the animation
//                   Text(
//                     'Easy Coupon',
//                     style: GoogleFonts.merriweather(
//                       color: Colors.white,
//                       fontSize: screenWidth * 0.08, // Responsive text size
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               bottom: screenHeight * 0.05,
//               left: 0,
//               right: 0,
//               child: Text(
//                 'A Project By DEIE 22nd Batch',
//                 style: GoogleFonts.merriweather(
//                   color: Colors.white,
//                   fontSize: screenWidth * 0.04, // Responsive text size
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






import 'dart:async';
import 'package:easy_coupon/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _auraAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _auraAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 4), () {
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const landing_pages(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // Right to left transition
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: const Color(0xFF294B29), // Set the background color here
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated circular aura around the animation
                  AnimatedBuilder(
                    animation: _auraAnimation,
                    builder: (context, child) {
                      return Container(
                        width: screenWidth * 0.6 * _auraAnimation.value,
                        height: screenWidth * 0.6 * _auraAnimation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF50623A).withOpacity(0.6),
                              blurRadius: 50,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                        child: child,
                      );
                    },
                    child: Lottie.asset(
                      'assets/images/landing/salad.json',
                      width: screenWidth * 0.5,
                      height: screenWidth * 0.5,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Text under the animation
                  Text(
                    'Easy Coupon',
                    style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontSize: screenWidth * 0.08, // Responsive text size
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.05,
              left: 0,
              right: 0,
              child: Text(
                'A Project By DEIE 22nd Batch',
                style: GoogleFonts.merriweather(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04, // Responsive text size
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
