import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:easy_coupon/pages/login_pages/login_page.dart';

class PwReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Stack(  // Use Stack to overlay widgets
          children: <Widget>[
            Positioned(
              top: size.height * 0.1,    // Move the image slightly below the top
              right: -20,   // Move the image further to the right
              child: Container(
                width: size.width * 0.6, // Adjust width as needed
                child: Image.asset(
                  "assets/images/landing/pw.png",
                  fit: BoxFit.contain, // Maintain aspect ratio
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.2,   // Move the text upwards
              left: 40,  // Align text to the left
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "RESET YOUR\nPASSWORD",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF294B29),
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.4,  // Adjust position to place below the title
              left: 40,
              right: 40,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Current Password",  // Corrected typo
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "New Password",
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      padding: EdgeInsets.zero,
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF294B29),
                            Color(0xFF50623A),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "RESET PASSWORD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}











