import 'package:easy_coupon/pages/student_pages/profile/profile_menu.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_update_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/components/background.dart'; // Import the Background widget
import 'package:easy_coupon/widgets/common/bottom_navigation.dart'; // Import the BottomNavigationBar widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                    const Text(
                      "Settings",
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
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Image(
                                  image:
                                      AssetImage("assets/images/profile.png")),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Color(0xFF789461),
                              ),
                              child: const Icon(
                                LineAwesomeIcons.alternate_pencil,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Your Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF294B29),
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "Your Role/Title",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () =>
                              Get.to(() => const UpdateProfileScreen()),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor:
                                Color(0xFF294B29), // Gradient color for button
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF294B29),
                                  Color(0xFF50623A),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(0),
                            child: const Text(
                              "MY PROFILE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),
                      ProfileMenuWidget(
                        title: "About Us",
                        icon: LineAwesomeIcons.info,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        title: "Logout",
                        icon: LineAwesomeIcons.alternate_sign_out,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          Get.defaultDialog(
                            title: "LOGOUT",
                            titleStyle: TextStyle(
                                fontSize: 20, color: Color(0xFF294B29)),
                            content: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text("Are you sure, you want to Logout?"),
                            ),
                            confirm: ElevatedButton(
                              onPressed: () {
                                // Call the logout function
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                side: BorderSide.none,
                              ),
                              child: const Text("Yes"),
                            ),
                            cancel: OutlinedButton(
                              onPressed: () => Get.back(),
                              child: const Text("No"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Lottie.asset(
                'assets/images/landing/settings.json',
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
        bottomNavigationBar: bottomBar(2),
      ),
    );
  }
}

// Define the bottomBar function similar to the Student_report page
Widget bottomBar(int selectedIndex) {
  return BottomNavigationBar(
    currentIndex: selectedIndex,
    selectedItemColor: Color(0xFF789461),
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(LineAwesomeIcons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(LineAwesomeIcons.book),
        label: 'Reports',
      ),
      BottomNavigationBarItem(
        icon: Icon(LineAwesomeIcons.user),
        label: 'Profile',
      ),
    ],
    onTap: (index) {
      // Handle navigation logic based on index
      if (index == 0) {
        Get.toNamed('/home'); // Navigate to Home Page
      } else if (index == 1) {
        Get.toNamed('/reports'); // Navigate to Reports Page
      } else if (index == 2) {
        Get.toNamed('/profile'); // Navigate to Profile Page (current)
      }
    },
  );
}
