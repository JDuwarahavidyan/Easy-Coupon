import 'package:flutter/material.dart';


class UserProfileAvatar extends StatefulWidget {
  const UserProfileAvatar({super.key});

  @override
  State<UserProfileAvatar> createState() => _UserProfileAvatarState();
}

class _UserProfileAvatarState extends State<UserProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    // Example: This data could be fetched from a user profile
    const String profileImage =
        'assets/profile_picture.jpg'; // Example profile image path

    return const CircleAvatar(
      backgroundColor: Color(0xFFFF8900), // Frame color
      radius: 23, // Outer radius including frame
      child: CircleAvatar(
        radius: 20, // Inner radius excluding frame
        backgroundImage: AssetImage(profileImage),
        // child: Icon(Icons.person, size: 22), // Fallback icon
      ),
    );
  }
}
