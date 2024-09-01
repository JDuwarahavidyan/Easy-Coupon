import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class QrGen extends StatefulWidget {
  const QrGen({super.key, AnimationController? animationController});

  @override
  _QrGenState createState() => _QrGenState();
}

class _QrGenState extends State<QrGen> with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
  }

  Future<void> _saveImageToDownloads() async {
    try {
      // Load the image from the assets
      final ByteData imageData =
          await rootBundle.load('assets/images/landing/qrcode.jpg');

      // Get the external storage directory
      final Directory? directory = await getExternalStorageDirectory();
      final String path = directory!.path;

      // Define the Downloads directory and create it if it doesn't exist
      final String downloadDirPath = '$path/Download';
      final Directory downloadDir = Directory(downloadDirPath);

      if (!await downloadDir.exists()) {
        await downloadDir.create(recursive: true);
      }

      // Create the file in the Downloads directory
      final File imageFile = File('$downloadDirPath/qrcode.jpg');

      // Write the image data to the file
      await imageFile.writeAsBytes(imageData.buffer.asUint8List());

      // Notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code saved to Downloads folder')),
      );
    } catch (e) {
      print('Error saving image: $e');
    }
  }

  Future<void> _shareImage() async {
    try {
      // Load the image from the assets
      final ByteData imageData =
          await rootBundle.load('assets/images/landing/qrcode.jpg');

      // Get the directory to save the image temporarily
      final Directory directory = await getTemporaryDirectory();
      final String path = directory.path;
      final File imageFile = File('$path/qrcode.jpg');

      // Write the image data to the file
      await imageFile.writeAsBytes(imageData.buffer.asUint8List());

      // Share the image file
      Share.shareFiles([imageFile.path], text: 'Check out this QR Code!');
    } catch (e) {
      print('Error sharing image: $e');
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
        body: Stack(
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
                                  color:
                                      const Color(0xFF789461).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Transform.scale(
                                      scale: 1.7,
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Lottie.asset(
                                          'assets/images/landing/qr_h.json',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Image.asset(
                                'assets/images/landing/qrcode.jpg',
                                height: 250,
                                width: 550,
                              ),
                              const SizedBox(height: 20),
                              Lottie.asset(
                                'assets/images/landing/qr_c.json',
                                height: 250,
                                width: 250,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
