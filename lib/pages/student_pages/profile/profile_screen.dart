import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'constants.dart'; // Import the constants file
import 'dummy_authentication.dart';
import 'profile_update_screen.dart';
import 'profile_menu.dart';
import 'package:easy_coupon/widgets/components/background.dart'; // Import the Background widget
import 'package:easy_coupon/widgets/common/bottom_navigation.dart'; // Import the BottomNavigationBar widget

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Background(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFDBE7C9),
          title:
              Text(tProfile, style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(tDefaultSize),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:
                                  const Image(image: AssetImage(tProfileImage)),
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
                                color: tPrimaryColor,
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
                      Text(tProfileHeading,
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text(tProfileSubHeading,
                          style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () =>
                              Get.to(() => const UpdateProfileScreen()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tPrimaryColor,
                            side: BorderSide.none,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(tEditProfile,
                              style: TextStyle(color: tDarkColor)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),
                      ProfileMenuWidget(
                        title: "Information",
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
                            titleStyle: const TextStyle(fontSize: 20),
                            content: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text("Are you sure, you want to Logout?"),
                            ),
                            confirm: ElevatedButton(
                              onPressed: () {
                                AuthenticationRepository.logout();
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
    selectedItemColor: tPrimaryColor,
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
