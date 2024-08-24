import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

class DonutChart extends StatefulWidget {
  final Animation<double> animation;

  const DonutChart({
    Key? key,
    required this.animation,
  }) : super(key: key);

  @override
  _DonutChartState createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  int currentValue = 0;

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
          painter: DonutChartPainter(
            remainingPercentage: remainingPercentage,
            animationValue: widget.animation.value,
            remainingColor: Color(0xFF50623A),
            usedColor: Colors.grey.shade300,
          ),
          child: Container(
            width: 200,
            height: 200,
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
                  Text(
                    '${30 - currentValue}',  // Display remaining coupons
                    style: const TextStyle(
                      fontSize: 30,
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

    // Paint for remaining coupons
    final remainingPaint = Paint()
      ..color = remainingColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round; // Round the edges

    // Paint for used coupons
    final usedPaint = Paint()
      ..color = usedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    // Draw used coupons arc (background)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * animationValue,
      false,
      usedPaint,
    );

    // Draw remaining coupons arc (foreground)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * remainingPercentage * animationValue,
      false,
      remainingPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DonutChart extends StatefulWidget {
//   final Animation<double> animation;

//   const DonutChart({
//     Key? key,
//     required this.animation,
//   }) : super(key: key);

//   @override
//   _DonutChartState createState() => _DonutChartState();
// }

// class _DonutChartState extends State<DonutChart> {
//   int currentValue = 0;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromFirebase();
//   }

//   void fetchDataFromFirebase() async {
//     try {
//       DocumentSnapshot doc = await FirebaseFirestore.instance
//           .collection('your_collection')
//           .doc('your_document')
//           .get();
//       setState(() {
//         currentValue = doc['your_field'];
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double remainingPercentage = (30 - currentValue) / 30.0;

//     return AnimatedBuilder(
//       animation: widget.animation,
//       builder: (context, child) {
//         return CustomPaint(
//           painter: DonutChartPainter(
//             remainingPercentage: remainingPercentage,
//             animationValue: widget.animation.value,
//             remainingColor: Color(0xFF50623A),
//             usedColor: Colors.grey.shade300,
//           ),
//           child: Container(
//             width: 150, // Reduced width
//             height: 150, // Reduced height
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Remaining Coupons',
//                     style: TextStyle(
//                       fontSize: 14, // Reduced font size
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   Text(
//                     '${30 - currentValue}',  // Display remaining coupons
//                     style: const TextStyle(
//                       fontSize: 24, // Reduced font size
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF50623A),
//                     ),
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
//     final radius = size.width / 2 - 4; // Adjusted for smaller size

//     // Paint for remaining coupons
//     final remainingPaint = Paint()
//       ..color = remainingColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 16 // Reduced stroke width
//       ..strokeCap = StrokeCap.round;

//     // Paint for used coupons
//     final usedPaint = Paint()
//       ..color = usedColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 16; // Reduced stroke width

//     // Draw used coupons arc (background)
//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi / 2,
//       2 * math.pi * animationValue,
//       false,
//       usedPaint,
//     );

//     // Draw remaining coupons arc (foreground)
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
