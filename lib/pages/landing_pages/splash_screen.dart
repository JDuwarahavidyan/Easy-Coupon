import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_coupon/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    Timer(const Duration(seconds: 7), () {
      _checkSession(mounted, context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkSession(bool mounted, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    final int? expiryTime = prefs.getInt('expiryTime');
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (userId != null && expiryTime != null && currentTime < expiryTime) {
      _checkUserRole(userId, mounted, context);
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.introductionAnimation);
      }
    }
  }

  Future<void> _checkUserRole(String uid, bool mounted, BuildContext context) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        String role = userDoc.get('role');
        if (mounted) {
          if (role == 'student') {
            Navigator.pushReplacementNamed(context, RouteNames.student);
          } else if (role == 'canteena') {
            Navigator.pushReplacementNamed(context, RouteNames.canteena);
          } else if (role == 'canteenb') {
            Navigator.pushReplacementNamed(context, RouteNames.canteenb);
          } else {
            Navigator.pushReplacementNamed(context, RouteNames.introductionAnimation);
          }
        }
      } else {
        if (mounted) {
          Navigator.pushReplacementNamed(context, RouteNames.introductionAnimation);
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.introductionAnimation);
      }
    }
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
                              color: const Color.fromRGBO(80, 98, 58, 1)
                                  .withOpacity(0.6),
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
