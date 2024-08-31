import 'dart:async';
import 'package:easy_coupon/pages/student_pages/student_home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/widgets.dart'; // Import the Background widget

class ConfirmationPage extends StatefulWidget {
  final int val;
  final String role;
  final String canteenUserId;
  final DateTime scannedTime;

  const ConfirmationPage({
    super.key,
    required this.val,
    required this.role,
    required this.canteenUserId,
    required this.scannedTime,
  });

  @override
  _ConfirmationPageState createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  late int _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = 600; // 10 minutes in seconds

    // Schedule the automatic navigation after 10 minutes
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _navigateToStudentHomeScreen(context);
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('yyyy-MM-dd – hh:mm a').format(widget.scannedTime);
    final minutes = _remainingTime ~/ 60;
    final seconds = _remainingTime % 60;

    return Scaffold(
      body: Background(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0), // Subtle upward lift
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/landing/done.json', 
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 10), // Reduced space here
                Text(
                  '${widget.val}',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Coupons',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10), // Slightly reduced space here
                Text(
                  formattedTime,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10), // Slightly reduced space here
                Text(
                  widget.role == 'canteena' ? 'Kalderama' : 'Hilton',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10), // Slightly reduced space here
                Text(
                  'This page will automatically close in $minutes:${seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 22, 22, 22)),
                ),
                SizedBox(height: 15), // Adjusted size here
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _navigateToStudentHomeScreen(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF294B29), // Dark green background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded edges
                      ),
                    ),
                    child: const Text(
                      'CLOSE NOW',
                      style: TextStyle(
                        color: Colors.white, // White text color
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToStudentHomeScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => StudentHomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: curve,
          );

          return SlideTransition(
            position: tween.animate(curvedAnimation),
            child: child,
          );
        },
        transitionDuration: const Duration(seconds: 1),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
