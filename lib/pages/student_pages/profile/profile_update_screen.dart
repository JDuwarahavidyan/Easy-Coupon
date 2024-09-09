import 'dart:io';

import 'package:easy_coupon/models/user/user_model.dart';
import 'package:easy_coupon/pages/student_pages/student_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'package:easy_coupon/pages/login_pages/pw_email_reset_page.dart';
import 'package:easy_coupon/pages/student_pages/profile/profile_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../bloc/blocs.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  Future<void> _pickAndUploadImage(UserModel user) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      if (Platform.isAndroid) {
        // Using UCrop for Android cropping
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
            ),
          ],
        );

        if (croppedFile != null) {
          // Deleting the old profile picture from Firebase Storage
          if (user.profilePic != null && user.profilePic!.isNotEmpty) {
            context.read<UserBloc>().add(DeleteProfilePictureEvent(user.profilePic!));
          }

          // Uploading the cropped image
          context.read<UserBloc>().add(UploadPictureEvent(croppedFile.path, user.id));
        }
      } else if (Platform.isIOS) {
        // Using ImageCropper for iOS
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0), // Square crop
          uiSettings: [
            IOSUiSettings(
              title: 'Crop Image',
              doneButtonTitle: 'Done',
              cancelButtonTitle: 'Cancel',
            ),
          ],
        );

        if (croppedFile != null) {
          // Deleting the old profile picture from Firebase Storage
          if (user.profilePic != null && user.profilePic!.isNotEmpty) {
            context.read<UserBloc>().add(DeleteProfilePictureEvent(user.profilePic!));
          }

          // Uploading the cropped image
          context.read<UserBloc>().add(UploadPictureEvent(croppedFile.path, user.id));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Fetch size from MediaQuery
    final size = MediaQuery.of(context).size;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UploadPictureSuccess) {
          // Handle any necessary actions when user data is loaded
        }
      },
      child: Background(
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

                if (user == null) {
                  return const Center(child: Text('User not found'));
                }
                return SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            user.profilePic!.isEmpty
                                ? GestureDetector(
                                    onTap: () => _pickAndUploadImage(user),
                                    child: SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/images/landing/userImage.png",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () => _pickAndUploadImage(user),
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey, // Gray background color
                                        shape: BoxShape.circle, // Circular background to match the rounded image
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center, // Align the person icon in the center
                                        children: [
                                          const Icon(
                                            Icons.person,
                                            size: 80,
                                            color: Colors.white, // Person icon with white color
                                          ),
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(100),
                                            child: Image.network(
                                              user.profilePic!,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Icon(Icons.error, size: 120); // Show error icon if image fails to load
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
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
                        const SizedBox(height: 50),
                        Form(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(LineAwesomeIcons.user),
                                title: Text("Full Name"),
                                subtitle: Text(
                                  user.userName[0].toUpperCase() + user.userName.substring(1),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ListTile(
                                leading: Icon(LineAwesomeIcons.envelope_1),
                                title: Text("Email"),
                                subtitle: Text(user.email),
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
