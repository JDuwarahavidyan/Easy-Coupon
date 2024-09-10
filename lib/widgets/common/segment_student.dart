// import 'package:easy_coupon/bloc/blocs.dart';
// import 'package:easy_coupon/bloc/home/home_bloc.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Ensure you have this import for Bloc usage

// class DonutChart extends StatefulWidget {
//   final Animation<double> animation;
//   final int couponCount;

//   const DonutChart({Key? key, required this.animation, required this.couponCount}) : super(key: key);

//   @override
//   _DonutChartState createState() => _DonutChartState();
// }

// class _DonutChartState extends State<DonutChart> {
//   late int currentValue;

//   @override
//   void initState() {
//     super.initState();
//     currentValue = widget.couponCount;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double remainingPercentage = (30 - currentValue) / 30.0; // Ensure it is between 0 and 1

//     // Obtain the UserBloc from the context
//     final UserBloc userBloc = context.read<UserBloc>();

//     return AnimatedBuilder(
//       animation: widget.animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: DonutChartPainter(
//             remainingPercentage: remainingPercentage,
//             animationValue: widget.animation.value,
//             remainingColor: const Color(0xFF50623A),
//             usedColor: Colors.grey.shade300,
//           ),
//           child: SizedBox(
//             width: 200, // Adjusted to a smaller size
//             height: 200, // Equal height to maintain circular shape
//             child: Center(
//               child: BlocBuilder<UserBloc, UserState>(
//                 bloc: userBloc,
//                 builder: (context, state) {
//                   if (state is UserLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (state is UserLoaded) {
//                     try {
//                       final user = state.users.firstWhere(
//                         (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
//                         orElse: () => throw Exception('User not found'),
//                       );

//                       return Text(
//                         '${user.studentCount}', // Display remaining coupons
//                         style: const TextStyle(
//                           fontSize: 90, // Adjusted for better fit
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF50623A),
//                         ),
//                       );
//                     } catch (e) {
//                       return const Center(child: Text('User data not found'));
//                     }
//                   } else {
//                     return const Center(child: Text('Failed to load user data'));
//                   }
//                 },
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class DonutChartPainter extends CustomPainter {
//   final double remainingPercentage;
//   final double animationValue;
//   final Color remainingColor;
//   final Color usedColor;

//   DonutChartPainter({
//     required this.remainingPercentage,
//     required this.animationValue,
//     required this.remainingColor,
//     required this.usedColor,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = math.min(size.width, size.height) / 2 - 10; // Adjusted to fit within the container

//     final remainingPaint = Paint()
//       ..color = remainingColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 15
//       ..strokeCap = StrokeCap.round;

//     final usedPaint = Paint()
//       ..color = usedColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 15;

//     // Draw the background (used part) arc
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi / 2,
//       2 * math.pi,
//       false,
//       usedPaint,
//     );

//     // Draw the remaining part of the arc
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi / 2,
//       2 * math.pi * remainingPercentage * animationValue,
//       false,
//       remainingPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
