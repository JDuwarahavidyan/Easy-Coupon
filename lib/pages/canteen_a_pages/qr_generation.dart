import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/common/background.dart'; // Import the Background widget

class QrGen extends StatelessWidget {
  const QrGen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Ensure transparency to see the background
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "You can scan now",
                style: TextStyle(
                  
                  fontSize: 20,
                  color: Color(0xFF294B29), // Use the same green color you previously used
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
                height: 150, // Adjust as needed
                width: 150, // Adjust as needed
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
          ),
        ),
      ),
    );
  }
}
