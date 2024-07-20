// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

// class SegmentedCircularIndicator extends StatefulWidget {
//   final Animation<double>? animation;
//   final List<Color> colors;

//   const SegmentedCircularIndicator({
//     Key? key,
//     required this.animation,
//     required this.colors,
//   }) : super(key: key);

//   @override
//   _SegmentedCircularIndicatorState createState() =>
//       _SegmentedCircularIndicatorState();
// }

// class _SegmentedCircularIndicatorState
//     extends State<SegmentedCircularIndicator> {
//   int currentValue = 30;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromFirebase();
//   }

//   // Function to fetch data from Firebase
//   void fetchDataFromFirebase() async {
//     DocumentSnapshot doc = await FirebaseFirestore.instance
//         .collection('your_collection')
//         .doc('your_document')
//         .get();
//     setState(() {
//       currentValue = doc['your_field']; // Update with your field
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double percentage = currentValue / 30.0;
//     return CustomPaint(
//       painter: GradientCircularPainter(
//         percentage: percentage,
//         colors: widget.colors,
//       ),
//       child: Container(
//         width: 150,
//         height: 150,
//         child: Center(
//           child: Text(
//             '$currentValue',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class GradientCircularPainter extends CustomPainter {
//   final double percentage;
//   final List<Color> colors;

//   GradientCircularPainter({required this.percentage, required this.colors});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
//     final gradient = SweepGradient(
//       startAngle: 0.0,
//       endAngle: math.pi * 2,
//       colors: colors,
//     );

//     final paint = Paint()
//       ..shader = gradient.createShader(rect)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 12;

//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = size.width / 2 - 6;

//     canvas.drawArc(
//       Rect.fromCircle(center: center, radius: radius),
//       -math.pi / 2,
//       2 * math.pi * percentage,
//       false,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }









import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';

class SegmentedCircularIndicator extends StatefulWidget {
  final List<Color> colors;
  final Animation<double> animation;

  const SegmentedCircularIndicator({
    Key? key,
    required this.colors,
    required this.animation,
  }) : super(key: key);

  @override
  _SegmentedCircularIndicatorState createState() =>
      _SegmentedCircularIndicatorState();
}

class _SegmentedCircularIndicatorState extends State<SegmentedCircularIndicator>
    with SingleTickerProviderStateMixin {
  int currentValue = 20;

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
    double percentage = currentValue / 30.0;

    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return CustomPaint(
          painter: GradientCircularPainter(
            percentage: widget.animation.value * percentage,
            colors: widget.colors,
          ),
          child: Container(
            width: 200,
            height: 200,
            child: Center(
              child: Text(
                '$currentValue',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GradientCircularPainter extends CustomPainter {
  final double percentage;
  final List<Color> colors;

  GradientCircularPainter({required this.percentage, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.width);
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: math.pi * 2,
      colors: colors,
      stops: [0.0, percentage, percentage, 1.0],
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percentage,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
