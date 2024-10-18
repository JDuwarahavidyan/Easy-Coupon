import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/pages/canteen_a_pages/canteen_a_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart'; // Import gallery_saver package
import 'package:path/path.dart' as path;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class QrGen extends StatefulWidget {
  const QrGen({super.key, AnimationController? animationController});

  @override
  _QrGenState createState() => _QrGenState();
}

class _QrGenState extends State<QrGen> with TickerProviderStateMixin {
  AnimationController? animationController;
  final GlobalKey globalKey = GlobalKey();
  final ScreenshotController screenshotController = ScreenshotController();
  String? qrData;

  // Define static key and IV
  final key = encrypt.Key.fromUtf8('easycouponkey@ruhunaengfac22TDDS');
  final iv = encrypt.IV.fromUtf8('easyduwarahan#27');

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    final canteenUserId = FirebaseAuth.instance.currentUser?.uid;
    if (canteenUserId != null) {
      context.read<UserBloc>().add(UserGenerateQREvent(canteenUserId));
    }
  }

  String encryptData(String data) {
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }


Future<void> _saveImageToGallery() async {
  try {
    final imageBytes = await screenshotController.capture();

    if (imageBytes != null) {
      // Request storage permission
      final permissionStatus = await Permission.storage.request();

      if (permissionStatus.isGranted) {
        // Manually specify a path (you can choose another path as needed)
        final imagePath = path.join('/storage/emulated/0/Download', 'screenshot.png');

        // Create a file and write the image bytes to it
        final imageFile = File(imagePath);
        await imageFile.writeAsBytes(imageBytes);

        // Save the image to the gallery
        final result = await GallerySaver.saveImage(imageFile.path);

        if (result == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('QR code saved to gallery')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to save QR code')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied to save the image')),
        );
      }
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error saving image: $e')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFFDBE7C9),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CanteenAMainPage()),
              );
            },
            icon: const Icon(LineAwesomeIcons.angle_left),
          ),
          title: const Text(
            "Generate the QR",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF294B29),
              fontSize: 25,
            ),
          ),
        ),
        extendBody: false,
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserQRGenerated) {
              final encryptedData = encryptData(state.qrData);
              setState(() {
                qrData = encryptedData; // Store encrypted QR data in the state
              });
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserQRGenerated || qrData != null) {
              final displayQRData = qrData ?? '';
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF789461).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Center(
                                            child: Text(
                                              'You can scan now',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Center(
                                            child: Screenshot(
                                              controller: screenshotController,
                                              child: RepaintBoundary(
                                                key: globalKey,
                                                child: Container(
                                                  padding: const EdgeInsets.all(20),
                                                  color: Colors.white,
                                                  child: QrImageView(
                                                    data: displayQRData,
                                                    version: QrVersions.auto,
                                                    size: 250,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Lottie.asset(
                                      'assets/images/landing/qr_c.json',
                                      height: 150,
                                      width: 150,
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: MaterialButton(
                                        onPressed: _saveImageToGallery,
                                        color: const Color(0xFF50623A),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Text(
                                          "Save to Device",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        minWidth: 150,
                                        height: 50,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: Text("No QR Code generated."));
          },
        ),
      ),
    );
  }
}
