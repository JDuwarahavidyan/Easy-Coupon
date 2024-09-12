import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_menu.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_update_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'package:easy_coupon/pages/student_pages/profile/aboutUs.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/blocs.dart';

class CanteenProfileScreen extends StatefulWidget {
  const CanteenProfileScreen({super.key});

  @override
  _CanteenProfileScreenState createState() => _CanteenProfileScreenState();
}

class _CanteenProfileScreenState extends State<CanteenProfileScreen> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            "LOGOUT",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF294B29)),
          ),
          content: const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              "Are you sure you want to Logout?",
              style: TextStyle(fontSize: 16, color: Color(0xFF294B29)),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(fontSize: 16, color: Color(0xFF294B29), fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Ensure LoginPage() is defined
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF789461),
                textStyle: const TextStyle(color: Colors.white),
              ),
              child: const Text("Yes", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          // Handle any necessary actions when user data is loaded
        }
      },
      child: Background(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserLoading) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: Color(0xFF50623A),
                    size: 50,
                  ),
                );
              } else if (state is UserLoaded) {
                final user = state.users.firstWhere(
                  (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
                );

                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      decoration: BoxDecoration(
                        color: Color(0xFFDBE7C9).withOpacity(0.1),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Settings ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF294B29),
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  user.profilePic!.isEmpty
                                      ? SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image.asset(
                                              "assets/images/landing/userImage.png",
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.grey, // Gray background color
                                            shape: BoxShape.circle, // Circular background to match the rounded image
                                          ),
                                          child: Stack(
                                            alignment: Alignment.center, // Align the person icon in the center
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 80,
                                                color: Colors.white, // Person icon with white color
                                              ),
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(100),
                                                child: Image.network(
                                                  user.profilePic!,
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Icon(Icons.error, size: 120); // Show error icon if image fails to load
                                                  },
                                                ),
                                              ),
                                            ],
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
                                        color: const Color(0xFF789461),
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
                                user.userName[0].toUpperCase() + user.userName.substring(1),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF294B29),
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                user.role[0].toUpperCase() + user.role.substring(1),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const UpdateProfileScreen(
                                                userRole: 'canteen',
                                              )),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80.0),
                                    ),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: const Color(0xFF294B29),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80.0),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF294B29),
                                          Color(0xFF50623A),
                                        ],
                                      ),
                                    ),
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
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AboutUs()),
                                  );
                                },
                              ),
                              ProfileMenuWidget(
                                title: "Logout",
                                icon: LineAwesomeIcons.alternate_sign_out,
                                textColor: Colors.red,
                                endIcon: false,
                                onPress: () => _showLogoutDialog(context),
                              ),
                              const SizedBox(height: 40),
                              Transform.translate(
                                offset: const Offset(0, -55),
                                child: Lottie.asset(
                                  'assets/images/landing/settings.json',
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('Failed to load user data'));
              }
            },
          ),
        ),
      ),
    );
  }
}
