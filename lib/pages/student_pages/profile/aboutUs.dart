import 'package:easy_coupon/pages/student_pages/profile/profile_menu.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/components/background.dart'; // Import the Background widget
import 'package:easy_coupon/widgets/common/bottom_navigation.dart'; // Import the BottomNavigationBar widget

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        backgroundColor:
            Colors.transparent, // Ensure transparency to see the background
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top), // For status bar
              decoration: BoxDecoration(
                color: Color(0xFFDBE7C9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "About Us",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF294B29),
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(isDark
                          ? LineAwesomeIcons.sun
                          : LineAwesomeIcons.moon),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0), // tDefaultSize
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Lottie.asset(
                              'assets/images/landing/salad.json',
                              width: 200,
                              height: 200,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Easy Coupon",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF294B29),
                          fontSize: 25,
                        ),
                      ),
                      const Text(
                        "Fast and Easy",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),
                      const Text(
                        "Easy Coupon is designed to simplify and streamline the process of issuing and redeeming food coupons for students. With a user-friendly interface and quick access to essential features, this app ensures that students can easily manage their meal plans without any hassle.",
                        style: TextStyle(
                          color: Color(0xFF294B29),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Our goal is to make the coupon management system more efficient and accessible for everyone involved, providing a seamless experience from start to finish. Whether you're a student looking to redeem a coupon or an administrator managing the system, Easy Coupon offers the tools you need to get the job done effectively.",
                        style: TextStyle(
                          color: Color(0xFF294B29),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
