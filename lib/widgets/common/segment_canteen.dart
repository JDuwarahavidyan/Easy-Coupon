// import 'package:easy_coupon/bloc/blocs.dart';
// import 'package:easy_coupon/bloc/user/user_bloc.dart';
// //import 'package:easy_coupon/widgets/common/segment.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Donut_c_Chart extends StatefulWidget {
//   final Animation<double> animation;


//   const Donut_c_Chart({Key? key, required this.animation}) : super(key: key);

//   @override
//   _Donut_c_ChartState createState() => _Donut_c_ChartState();
// }

// class _Donut_c_ChartState extends State<Donut_c_Chart> {
//   late int currentValue;

//   @override
//   void initState() {
//     super.initState();
    
//   }

//   @override
//   Widget build(BuildContext context) {
    

//     final UserBloc userBloc = context.read<UserBloc>();

//     return AnimatedBuilder(
//       animation: widget.animation,
//       builder: (context, child) {
//         return CustomPaint(
          
//           child: SizedBox(
//             width: 300,
//             height: 150,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Remaining Coupons',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   BlocBuilder<UserBloc, UserState>(
//                     bloc: userBloc,
//                     builder: (context, state) {
//                       if (state is UserLoading) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (state is UserLoaded) {
//                         //state.users;
//                         try {
//                           final user = state.users.firstWhere(
//                             (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
//                             orElse: () => throw Exception('User not found'),
//                           );                         
//                           return Text(
//                             '${user.canteenCount}', // Display remaining coupons
//                             style: const TextStyle(
//                               fontSize: 70,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF50623A),
//                             ),
//                           );
//                         } catch (e) {
//                           return const Center(child: Text('User data not found'));
//                         }
//                       } else {
//                         return const Center(child: Text('Failed to load user data'));
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // ignore: camel_case_types
// class Donut_c_ChartPainter extends CustomPainter {
//   final double remainingPercentage;
//   final double animationValue;
//   final Color remainingColor;
//   final Color usedColor;

//   Donut_c_ChartPainter({
//     required this.remainingPercentage,
//     required this.animationValue,
//     required this.remainingColor,
//     required this.usedColor,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2 - 6;

//     final remainingPaint = Paint()
//       ..color = remainingColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 20
//       ..strokeCap = StrokeCap.round;

//     final usedPaint = Paint()
//       ..color = usedColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 20;

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi / 2,
//       2 * math.pi * animationValue,
//       false,
//       usedPaint,
//     );

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi / 2,
//       2 * math.pi * remainingPercentage * animationValue,
//       false,
//       remainingPaint,
//     );

//     print('remainingPercentage: $remainingPercentage, animationValue: $animationValue');
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
