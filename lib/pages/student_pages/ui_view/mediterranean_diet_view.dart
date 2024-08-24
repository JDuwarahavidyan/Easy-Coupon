// import 'package:easy_coupon/widgets/common/segment.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
// import 'package:easy_coupon/widgets/common/segment.dart';
// import 'package:easy_coupon/main.dart';
// import 'package:easy_coupon/widgets/widgets.dart';
// // Import the new widget

// class MediterranesnDietView extends StatelessWidget {
//   final AnimationController? animationController;
//   final Animation<double>? animation;

//   const MediterranesnDietView({
//     Key? key,
//     this.animationController,
//     this.animation,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: new Transform(
//             transform: new Matrix4.translationValues(
//               0.0,
//               30 * (1.0 - animation!.value),
//               0.0,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   left: 24, right: 24, top: 16, bottom: 18),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: StudentTheme.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8.0),
//                     bottomLeft: Radius.circular(8.0),
//                     bottomRight: Radius.circular(8.0),
//                     topRight: Radius.circular(68.0),
//                   ),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: StudentTheme.grey.withOpacity(0.2),
//                       offset: Offset(1.1, 1.1),
//                       blurRadius: 10.0,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(top: 16, left: 16, right: 16),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 8, right: 8, top: 4),
//                               child: Column(
//                                 children: <Widget>[
//                                   SizedBox(
//                                     height: 8,
//                                   ),
//                                   // Additional content here
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 16),
//                             child: Center(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                   ),
//                                   SegmentedCircularIndicator(
//                                     animation: animation!,
//                                     colors: [
//                                       AppColors.landColor,
//                                       AppColors.hlColor,
//                                       AppColors.skyColor,
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
                   
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }















import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/common/segment.dart'; // Import the new widget
import 'package:cloud_firestore/cloud_firestore.dart';

class MediterranesnDietView extends StatefulWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const MediterranesnDietView({
    Key? key,
    this.animationController,
    this.animation,
  }) : super(key: key);

  @override
  _MediterranesnDietViewState createState() => _MediterranesnDietViewState();
}

class _MediterranesnDietViewState extends State<MediterranesnDietView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    widget.animationController?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation!,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - widget.animation!.value),
              0.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(68.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 8),
                                  // Additional content here
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  ),
                                  DonutChart(
                                    animation: _animation,
                                    // colors: [
                                     
                                    // ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
