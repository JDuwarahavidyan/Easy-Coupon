import 'dart:async';
import 'package:easy_coupon/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_coupon/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Timer(const Duration(seconds: 7), () {
      Navigator.pushReplacementNamed(context, RouteNames.introductionAnimation);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.splashColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Container(
                        width: 320 + 60 * _animation.value,
                        height: 320 + 60 * _animation.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:  AppColors.shadowColor
                                  .withOpacity(1 - _animation.value),
                              blurRadius: 1000 * _animation.value,
                              spreadRadius: 500 * _animation.value,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/landing/logo.png',
                          width: 160,
                          height: 160,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Text(
                'A Project By DEIE 22nd Batch',
                style: GoogleFonts.merriweather(
                  // Apply the serif font style here
                  color: AppColors.textColor,
                  fontSize: 14,
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
