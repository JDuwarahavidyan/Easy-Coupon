import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/student_report.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'package:easy_coupon/widgets/common/segment_c.dart'; // Import your DonutChart widget
import 'package:flutter/cupertino.dart'; // Import Cupertino icons


// ignore: camel_case_types
class  QrGen extends StatefulWidget {
  const  QrGen({super.key, AnimationController? animationController});

  @override
  // ignore: library_private_types_in_public_api
  _QrGenState createState() => _QrGenState();
}

class _QrGenState extends State< QrGen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  //List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();

    
    //tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

   
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
          appBar: AppBar(
          backgroundColor: Color(0xFFDBE7C9),
          title: Text(
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
                    padding: const EdgeInsets.only(bottom: 60), // Padding to avoid overlap
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF789461).withOpacity(0.1),
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
                                          Transform.scale(
                                            scale: 1.7, // Adjust the scale factor to increase the size of the Lottie animation
                                            child: SizedBox(
                                              width: 40, // Original size
                                              height: 40, // Original size
                                              child: Lottie.asset(
                                                'assets/images/landing/qr_h.json',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                                           SizedBox(height: 20), // Add space between text and image
              Image.asset(
                'assets/images/landing/qrcode.jpg',
                height: 250, // Adjust as needed
                width: 550, // Adjust as needed
              ),
              SizedBox(height: 20), // Add space between image and Lottie animation
              Lottie.asset(
                'assets/images/landing/qr_c.json',
                height: 250, // Adjust as needed
                width: 250, // Adjust as needed
              ),
               SizedBox(height: 20), // Add space between Lottie animation and button
              MaterialButton(
                onPressed: () {
                  // Add your share functionality here
                },
                color: Color(0xFF50623A), // Green color for the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded edges
                ),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                minWidth: 50,
                height: 50,
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
                // }
              // },
            // ),
          ],
        ),
        
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
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
