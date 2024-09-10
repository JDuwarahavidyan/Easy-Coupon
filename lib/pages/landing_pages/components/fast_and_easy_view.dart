// // ignore_for_file: no_leading_underscores_for_local_identifiers

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class MoodDiaryVew extends StatelessWidget {
//   final AnimationController animationController;

//   const MoodDiaryVew({super.key, required this.animationController});

//   @override
//   Widget build(BuildContext context) {
//     final _firstHalfAnimation =
//         Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.4,
//         0.6,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));
//     final _secondHalfAnimation =
//         Tween<Offset>(begin: const Offset(0, 0), end:const Offset(-1, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.6,
//         0.8,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));

//     final _moodFirstHalfAnimation =
//         Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.4,
//         0.6,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));
//     final _moodSecondHalfAnimation =
//         Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.6,
//         0.8,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));
//     final _imageFirstHalfAnimation =
//         Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve: const Interval(
//         0.4,
//         0.6,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));
//     final _imageSecondHalfAnimation =
//         Tween<Offset>(begin:const Offset(0, 0), end:const Offset(-4, 0))
//             .animate(CurvedAnimation(
//       parent: animationController,
//       curve:const Interval(
//         0.6,
//         0.8,
//         curve: Curves.fastOutSlowIn,
//       ),
//     ));

//     return SlideTransition(
//       position: _firstHalfAnimation,
//       child: SlideTransition(
//         position: _secondHalfAnimation,
//         child: Padding(
//           padding: const EdgeInsets.only(bottom: 0), // Reduced padding
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 "Fast and Easy",
//                 style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
//               ),
//               SlideTransition(
//                 position: _moodFirstHalfAnimation,
//                 child: SlideTransition(
//                   position: _moodSecondHalfAnimation,
//                   child:const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 64, vertical: 8), // Adjusted padding
//                     child: Text(
//                       "Lorem ipsum dolor sit amet,consectetur adipiscing elit,sed do eiusmod tempor incididunt ut labore",
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ),
//               SlideTransition(
//                 position: _imageFirstHalfAnimation,
//                 child: SlideTransition(
//                   position: _imageSecondHalfAnimation,
//                   child: Container(
//                     constraints: const BoxConstraints(maxWidth: 700, maxHeight: 700),
//                     child: Lottie.asset(
//                       'assets/images/landing/fast_easy.json',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MoodDiaryVew extends StatelessWidget {
  final AnimationController animationController;

  const MoodDiaryVew({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation = Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _secondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _moodFirstHalfAnimation = Tween<Offset>(begin: const Offset(2, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _moodSecondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-2, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageFirstHalfAnimation = Tween<Offset>(begin: const Offset(4, 0), end: const Offset(0, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation = Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-4, 0)).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0), // Reduced padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Fast and Easy",
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              SlideTransition(
                position: _moodFirstHalfAnimation,
                child: SlideTransition(
                  position: _moodSecondHalfAnimation,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 64, vertical: 8), // Adjusted padding
                    child: Text(
                      "Scan the QR code, show the validation message and get your food....It's that simple",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _imageFirstHalfAnimation,
                child: SlideTransition(
                  position: _imageSecondHalfAnimation,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400), // Adjusted size constraints
                    child: Image.asset(
                      'assets/images/landing/fast_easy.jpg',
                      fit: BoxFit.contain, // Adjusted BoxFit to contain
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
