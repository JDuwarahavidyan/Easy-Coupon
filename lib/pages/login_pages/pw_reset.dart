// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:easy_coupon/widgets/widgets.dart';
// import 'package:flutter_svg/svg.dart';

// class PwReset extends StatefulWidget {
//   const PwReset({Key? key}) : super(key: key);

//   @override
//   State<PwReset> createState() => _PwResetState();
// }

// class _PwResetState extends State<PwReset> {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.landColor,
//       // appBar: AppBar(
//       //   backgroundColor: Colors.transparent, // Transparent background
//       //   elevation: 0, // No shadow
//       //   leading: CupertinoNavigationBarBackButton( // Cupertino back button
//       //     onPressed: () {
//       //       Navigator.pushReplacementNamed(context, '/login');
//       //     },
//       //   ),
//       // ),
//       body: SafeArea(
//         child: SizedBox(
//           height: size.height,
//           child: Stack(
//             alignment: Alignment.center,
//             children: <Widget>[
//               // Background SVGs positioned here

//                           Positioned(
//                 left: -26,
//                 top: 51.0,
//                 child: SvgPicture.string(
//                   '<svg viewBox="-26.0 51.0 91.92 91.92" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -26.0, 96.96)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -10.83, 105.24)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 16.51, 93.51)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                   width: 91.92,
//                   height: 91.92,
//                 ),
//               ),

//               Positioned(
//                 left: -26,               
//                 bottom: 100,
//                 child: SvgPicture.string(
//                   '<svg viewBox="-26.0 51.0 91.92 91.92" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -26.0, 96.96)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -10.83, 105.24)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, 16.51, 93.51)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                   width: 91.92,
//                   height: 91.92,
//                 ),
//               ),

//               Positioned(
//                 right: 43.0,
//                 top: -103,
//                 child: SvgPicture.string(
//                   '<svg viewBox="63.0 -103.0 268.27 268.27" ><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 63.0, 67.08)" d="M 147.2896423339844 0 L 196.3861999511719 98.19309997558594 L 147.2896423339844 196.3861999511719 L 49.09654235839844 196.3861999511719 L 0 98.19309234619141 L 49.09656143188477 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 113.73, 79.36)" d="M 0 0 L 83.46413421630859 33.38565444946289 L 166.9282684326172 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 184.38, 23.77)" d="M 0 111.9401321411133 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                   width: 268.27,
//                   height: 268.27,
//                 ),
//               ),

//                 Positioned(
//                 right: 42.0,
//                 bottom: -120,
//                 child: SvgPicture.string(
//                   '<svg viewBox="63.0 -103.0 268.27 268.27" ><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 63.0, 67.08)" d="M 147.2896423339844 0 L 196.3861999511719 98.19309997558594 L 147.2896423339844 196.3861999511719 L 49.09654235839844 196.3861999511719 L 0 98.19309234619141 L 49.09656143188477 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 113.73, 79.36)" d="M 0 0 L 83.46413421630859 33.38565444946289 L 166.9282684326172 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="matrix(0.5, -0.866025, 0.866025, 0.5, 184.38, 23.77)" d="M 0 111.9401321411133 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                   width: 268.27,
//                   height: 268.27,
//                 ),
//               ),


//               Positioned(
//                 right: -19,
//                 top: 31.0,
//                 child: SvgPicture.string(
//                   '<svg viewBox="329.0 31.0 65.0 65.0" ><path transform="translate(329.0, 31.0)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(333.88, 47.58)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(361.5, 58.63)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                   width: 65.0,
//                   height: 65.0,
//                 ),
//               ),

              
//               Positioned(
//                 right: -19,
//                 bottom: 331.0,
//                 child: SvgPicture.string(
//                   '<svg viewBox="329.0 31.0 65.0 65.0" ><path transform="translate(329.0, 31.0)" d="M 48.75 0 L 65 32.5 L 48.75 65 L 16.24999809265137 65 L 0 32.5 L 16.25000381469727 0 Z" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(333.88, 47.58)" d="M 0 0 L 27.625 11.05000019073486 L 55.25 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(361.5, 58.63)" d="M 0 37.04999923706055 L 0 0" fill="none" stroke="#ffffff" stroke-width="1" stroke-opacity="0.25" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
//                   width: 65.0,
//                   height: 65.0,
//                 ),
//               ),


//               //card and footer ui
//               Positioned(
//                 bottom: 20.0,
//                 child: Column(
//                   children: <Widget>[
//                     buildCard(size),
//                     buildFooter(size),
//                   ],
//                 ),
//               ),

//               Positioned(
//                 bottom: 20.0,
//                 child: Column(
//                   children: <Widget>[
//                     buildCard(size),
//                     buildFooter(size),
//                   ],
//                 ),
//               ),

//                Positioned(
//             top: 20,
//             left: 20,
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/login');
//               },
//             ),
//           ),


//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Your existing methods for building card and footer widgets

//   Widget buildCard(Size size) {
//     return Container(
//       alignment: Alignment.center,
//       width: size.width * 0.9,
//       height: size.height * 0.7,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50.0),
//         color: Colors.white,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           logo(size.height / 8, size.height / 8),
//           SizedBox(height: size.height * 0.03),
//           richText(24),
//           SizedBox(height: size.height * 0.05),
//           emailTextField(size),
//           SizedBox(height: size.height * 0.02),
//           buildRememberForgetSection(),
//           SizedBox(height: size.height * 0.04),
//           signInButton(size),
//         ],
//       ),
//     );
//   }

//   Widget buildFooter(Size size) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         SizedBox(height: size.height * 0.04),
//         SizedBox(width: size.width * 0.6, height: 44.0),
//         SizedBox(height: size.height * 0.02),
//         Text.rich(
//           TextSpan(
//             style: GoogleFonts.inter(
//               fontSize: 12.0,
//               color: Colors.white,
//             ),
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget logo(double height_, double width_) {
//     return Image.asset(
//       'assets/images/landing/logo.png',
//       height: height_,
//       width: width_,
//     );
//   }

//   Widget richText(double fontSize) {
//     return Text.rich(
//       TextSpan(
//         style: GoogleFonts.inter(
//           fontSize: fontSize,
//           color: AppColors.landColor,
//           letterSpacing: 2.000000061035156,
//         ),
//         children: const [
//           TextSpan(
//             text: 'PASSWORD ',
//             style: TextStyle(
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           TextSpan(
//             text: 'RESET',
//             style: TextStyle(
//               color: AppColors.skyColor,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget emailTextField(Size size) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: SizedBox(
//         height: size.height / 12,
//         child: TextField(
//           controller: emailController,
//           style: GoogleFonts.inter(
//             fontSize: 18.0,
//             color: const Color(0xFF151624),
//           ),
//           maxLines: 1,
//           keyboardType: TextInputType.emailAddress,
//           cursorColor: const Color(0xFF151624),
//           decoration: InputDecoration(
//             labelText: 'Enter your email',
//             labelStyle: GoogleFonts.inter(
//               fontSize: 16.0,
//               color: const Color(0xFF151624).withOpacity(0.5),
//             ),
//             filled: true,
//             fillColor: emailController.text.isEmpty
//                 ? AppColors.shadowColor
//                 : AppColors.textColor,
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(40),
//               borderSide: BorderSide(
//                 color: emailController.text.isEmpty
//                     ? Color.fromARGB(0, 0, 0, 0)
//                     : AppColors.landColor,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(40),
//               borderSide: const BorderSide(
//                 color: AppColors.landColor,
//               ),
//             ),
//             prefixIcon: Icon(
//               Icons.mail_outline_rounded,
//               color: emailController.text.isEmpty
//                   ? const Color(0xFF151624).withOpacity(0.5)
//                   : AppColors.landColor,
//               size: 16,
//             ),
//             suffix: Container(
//               alignment: Alignment.center,
//               width: 24.0,
//               height: 24.0,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100.0),
//                 color: AppColors.landColor,
//               ),
//               child: emailController.text.isEmpty
//                   ? const Center()
//                   : const Icon(
//                       Icons.check,
//                       color: AppColors.primaryColor,
//                       size: 13,
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget signInButton(Size size) {
//     return Container(
//       width: size.width - 32.0,
//       height: size.height / 12,
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: TextButton(
//         style: TextButton.styleFrom(
//           padding: EdgeInsets.zero,
//           backgroundColor: AppColors.landColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(40.0),
//           ),
//           shadowColor: const Color(0xFF4C2E84).withOpacity(0.2),
//           elevation: 5.0,
//         ),
//         onPressed: () {
//           // Add your onPressed logic here
//         },
//         child: Center(
//           child: Text(
//             'SEND EMAIL',
//             style: GoogleFonts.inter(
//               fontSize: 18.0,
//               color: AppColors.primaryColor,
//               fontWeight: FontWeight.w600,
//               height: 1.5,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildRememberForgetSection() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.0),
//       child: Row(
//         children: [  
//           SizedBox(width: 8),
//           Spacer(),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:easy_coupon/pages/login_pages/login_page.dart';

class PwReset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "REGISTER",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Mobile Number",
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                ),
              ),
            ),

            SizedBox(height: size.height * 0.03),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
              ),
            ),

            SizedBox(height: size.height * 0.05),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
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
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInThree()),
                  )
                },
                child: Text(
                  "Already Have an Account? Sign in",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}













