import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

class Donut_c_Chart extends StatefulWidget {
  final Animation<double> animation;

  const Donut_c_Chart({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  _Donut_c_ChartState createState() => _Donut_c_ChartState();
}

class _Donut_c_ChartState extends State<Donut_c_Chart> {
  int currentValue = 10;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  void fetchDataFromFirebase() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('your_collection')
          .doc('your_document')
          .get();
      setState(() {
        currentValue = doc['your_field'];
      });
      print('Fetched value: $currentValue');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double remainingPercentage = (30 - currentValue) / 30.0;

    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return CustomPaint(
          painter: Donut_c_ChartPainter(
            remainingPercentage: remainingPercentage,
            animationValue: widget.animation.value,
            remainingColor: const Color(0xFF50623A),
            usedColor: Colors.grey.shade300,
          ),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Coupons Utilized Today',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    '$currentValue',  // Display remaining coupons
                    style: const TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF50623A),
                    ),
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

// ignore: camel_case_types
class Donut_c_ChartPainter extends CustomPainter {
  final double remainingPercentage;
  final double animationValue;
  final Color remainingColor;
  final Color usedColor;

  Donut_c_ChartPainter({
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
