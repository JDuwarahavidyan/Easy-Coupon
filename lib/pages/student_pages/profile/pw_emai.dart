import 'package:easy_coupon/routes/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/widgets.dart';

class PasswordEmailPage extends StatelessWidget {
    const PasswordEmailPage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,  
      body: Background(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: size.height * 0.05,
              left: 20,
              child: GestureDetector(
                onTap: () {
                   Navigator.pushReplacementNamed(context, RouteNames.updtprofile);
                },
                child: const Icon(
                  CupertinoIcons.back,
                  size: 30,
                  color: Color(0xFF294B29),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.1,
              right: -20,
              child: SizedBox(
                width: size.width * 0.6,
                child: Image.asset(
                  "assets/images/landing/pw.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.40,
              left: 40,
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "ENTER YOUR EMAIL TO\nRESET YOUR PASSWORD",
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
              top: size.height * 0.5,
              left: 40,
              right: 40,
              child: Column(
                children: <Widget>[
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Enter the Email",
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
                      textStyle: const TextStyle(
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
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF294B29),
                            Color(0xFF50623A),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "SEND EMAIL",
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
