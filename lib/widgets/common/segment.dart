import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/bloc/home/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Ensure you have this import for Bloc usage

class DonutChart extends StatefulWidget {
  final Animation<double> animation;
  final int couponCount;

  const DonutChart({Key? key, required this.animation, required this.couponCount}) : super(key: key);

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.couponCount;
  }

  @override
  Widget build(BuildContext context) {
    double remainingPercentage = (30 - currentValue).clamp(0, 30) / 30.0; // Ensure it is between 0 and 1

    // Obtain the UserBloc from the context
    final UserBloc userBloc = context.read<UserBloc>();
    //final user = FirebaseAuth.instance.currentUser?.uid;

    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return CustomPaint(
          painter: DonutChartPainter(
            remainingPercentage: remainingPercentage,
            animationValue: widget.animation.value,
            remainingColor: const Color(0xFF50623A),
            usedColor: Colors.grey.shade300,
          ),
          child: SizedBox(
            width: 300,
            height: 150,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Remaining Coupons',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    bloc: userBloc,
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is UserLoaded) {
                        //state.users;
                        try {
                          final user = state.users.firstWhere(
                            (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
                            orElse: () => throw Exception('User not found'),
                          );
                          currentValue = user.studentCount;
                          return Text(
                            '${30 - currentValue}', // Display remaining coupons
                            style: const TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF50623A),
                            ),
                          );
                        } catch (e) {
                          return const Center(child: Text('User data not found'));
                        }
                      } else {
                        return const Center(child: Text('Failed to load user data'));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final double remainingPercentage;
  final double animationValue;
  final Color remainingColor;
  final Color usedColor;

  DonutChartPainter({
    required this.remainingPercentage,
    required this.animationValue,
    required this.remainingColor,
    required this.usedColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    final remainingPaint = Paint()
      ..color = remainingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    final usedPaint = Paint()
      ..color = usedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * animationValue,
      false,
      usedPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * remainingPercentage * animationValue,
      false,
      remainingPaint,
    );

    print('remainingPercentage: $remainingPercentage, animationValue: $animationValue');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
