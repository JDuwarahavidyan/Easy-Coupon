import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/models/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

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
  final iv = encrypt.IV.fromUtf8('easyduwa');

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
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  Future<void> _saveImageToDownloads() async {
    final imageFile = await screenshotController.capture();
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/qr_code.png');
      await imagePath.writeAsBytes(imageFile);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR code saved to ${imagePath.path}')),
      );
    }
  }

  Future<void> _shareImage() async {
    final imageFile = await screenshotController.capture();
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = File('${directory.path}/qr_code.png');
      await imagePath.writeAsBytes(imageFile);
      if (qrData != null) {
        // Share.shareFiles([imagePath.path], text: 'Here is my QR code: $qrData');
        Share.shareFiles([imagePath.path], text: 'Check out this QR Code!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xFFDBE7C9),
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
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Expanded(
                                            child: Text(
                                              'You can scan now',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Screenshot(
                                            controller: screenshotController,
                                            child: RepaintBoundary(
                                              key: globalKey,
                                              child: Container(
                                                padding: const EdgeInsets.all(20),
                                                color: Colors.white,
                                                child: QrImageView(
                                                  data: displayQRData,
                                                  version: QrVersions.auto,
                                                  size: 200,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const SizedBox(height: 20),
                                    Lottie.asset(
                                      'assets/images/landing/qr_c.json',
                                      height: 250,
                                      width: 250,
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        MaterialButton(
                                          onPressed: _saveImageToDownloads,
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
                                        MaterialButton(
                                          onPressed: _shareImage,
                                          color: const Color(0xFF50623A),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.share,
                                            color: Colors.white,
                                          ),
                                          minWidth: 50,
                                          height: 50,
                                        ),
                                      ],
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
            return const Center(child: Text('Failed to load user data'));
          },
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:easy_coupon/widgets/common/background.dart';
// import 'package:share_plus/share_plus.dart'; // Import share_plus
// import 'package:path_provider/path_provider.dart'; // Import path_provider
// import 'dart:io'; // Import dart:io to handle file operations
// import 'package:flutter/services.dart'; // Import services to load assets

// class QrGen extends StatefulWidget {
//   const QrGen({super.key, AnimationController? animationController});

//   @override
//   _QrGenState createState() => _QrGenState();
// }

// class _QrGenState extends State<QrGen> with TickerProviderStateMixin {
//   AnimationController? animationController;

//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 600), vsync: this);
//   }

//   Future<void> _shareQrCode() async {
//     try {
//       // Load the image from assets
//       final ByteData bytes = await rootBundle.load('assets/images/landing/qrcode.jpg');
      
//       // Create a temporary directory
//       final Directory tempDir = await getTemporaryDirectory();
//       final String tempPath = tempDir.path;
      
//       // Write the image bytes to a file in the temp directory
//       final File file = File('$tempPath/qrcode.jpg');
//       await file.writeAsBytes(bytes.buffer.asUint8List());

//       // Share the file using the path to the temporary file
//       await Share.shareFiles(['assets/images/landing/qrcode.jpg'], text: 'Check out this QR code!');
//     } catch (e) {
//       print('Error sharing file: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: const Color(0xFFDBE7C9),
//           title: const Text(
//             "Generate the QR",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: Color(0xFF294B29),
//               fontSize: 25,
//             ),
//           ),
//         ),
//         extendBody: false,
//         body: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 60), // Padding to avoid overlap
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 50),
//                     const SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: LayoutBuilder(
//                         builder: (context, constraints) {
//                           return Column(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(8.0),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF789461).withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Expanded(
//                                       child: Text(
//                                         'You can scan now',
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.black87,
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10),
//                                     Transform.scale(
//                                       scale: 1.7, // Adjust the scale factor to increase the size of the Lottie animation
//                                       child: SizedBox(
//                                         width: 40,
//                                         height: 40,
//                                         child: Lottie.asset(
//                                           'assets/images/landing/qr_h.json',
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(height: 20), // Add space between text and image
//                               Image.asset(
//                                 'assets/images/landing/qrcode.jpg',
//                                 height: 250,
//                                 width: 550,
//                               ),
//                               const SizedBox(height: 20), // Add space between image and Lottie animation
//                               Lottie.asset(
//                                 'assets/images/landing/qr_c.json',
//                                 height: 250,
//                                 width: 250,
//                               ),
//                               const SizedBox(height: 20), // Add space between Lottie animation and button
//                               TextButton(
//                                 onPressed: _shareQrCode,
//                                 style: TextButton.styleFrom(
//                                   foregroundColor: Colors.white, 
//                                   backgroundColor: const Color(0xFF50623A), // Text color
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10), // Rounded edges
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Share',
//                                   style: TextStyle(fontSize: 16),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
