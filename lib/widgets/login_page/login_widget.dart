import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final Widget child;  // Define the named parameter 'child'

  const LoginWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,  // Ensure Scaffold resizes when keyboard appears
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: BottomClipper(),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.75,
                width: double.infinity,
                color: const Color(0xFFFF8A00),
                child: Center(
                  child: Transform.scale(
                    scale: 2.3,
                    child: Image.asset(
                      'assets/loginImage.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.3, // Adjust height as needed
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF8A00), Color(0xFFFFB400)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: child,  // This is where your text field or form should go
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var firstControlPoint = Offset(size.width / 5, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 50);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    var secondControlPoint =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
