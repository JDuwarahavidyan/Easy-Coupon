

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class Background extends StatelessWidget {
//   final Widget child;

//   const Background({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Container(
//       width: double.infinity,
//       height: size.height,
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           Positioned(
//            top: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/images/landing/top1.png",
//               width: size.width,
//             ),
//           ),
//             Positioned(
//            top: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/images/landing/top2.png",
//               width: size.width,
//             ),
//           ),
//           Positioned(
//            bottom: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/images/landing/bottom2.png",
//               width: size.width,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/images/landing/bottom1.png",
//               width: size.width,
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Image.asset(
//               "assets/images/landing/bottom_2.png",
//               width: size.width,
//             ),
//           ),
//           child,
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      color: Colors.white, // Set the background color to white
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              "assets/images/landing/top1.png",
              width: size.width,
            ),
          ),
          // Positioned(
          //   top: 0,
          //   right: 0,
          //   child: Image.asset(
          //     "assets/images/landing/top2.png",
          //     width: size.width,
          //   ),
          // ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/landing/bottom2.png",
              width: size.width,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/landing/bottom1.png",
              width: size.width,
            ),
          ),
          // Positioned(
          //   bottom: 0,
          //   right: 0,
          //   child: Image.asset(
          //     "assets/images/landing/bottom_2.png",
          //     width: size.width,
          //   ),
          // ),
          child,
        ],
      ),
    );
  }
}
