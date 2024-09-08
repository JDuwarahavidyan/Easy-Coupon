import 'package:easy_coupon/pages/student_pages/student_main.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'package:easy_coupon/pages/login_pages/pw_email_reset_page.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Fetch size from MediaQuery
    final size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Ensure transparency to see the background
        appBar: AppBar(
          backgroundColor: const Color(0xFFDBE7C9),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentMainPage(
                          currentIndex: 2,
                        )),
              );
            },
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF294B29),
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none, // Ensure the stack can overflow
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60), // Adjusted radius to 60 for better visual
                        child: Image.asset(
                          "assets/images/landing/userImage.png",
                          fit: BoxFit.cover, // Changed to cover for better fit
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.5), // Adjusted radius to 17.5
                          color: const Color(0xFF294B29),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Form(
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(LineAwesomeIcons.user),
                        title: Text("Full Name"),
                        subtitle: Text('John Doe'),
                      ),
                      const SizedBox(height: 20),
                      const ListTile(
                        leading: Icon(LineAwesomeIcons.envelope_1),
                        title: Text("Email"),
                        subtitle: Text('johndoe@example.com'),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PasswordEmailResetPage()),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF50623A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
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
                              "CHANGE PASSWORD",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent.withOpacity(0.1),
                          elevation: 0,
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                        ),
                        child: const Text(
                          "DELETE ACCOUNT",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
