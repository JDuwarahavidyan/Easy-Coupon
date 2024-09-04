// import 'package:easy_coupon/pages/pages.dart';
// import 'package:easy_coupon/pages/student_pages/student_report.dart';
// import 'package:easy_coupon/widgets/widgets.dart';
// import 'package:flutter/material.dart';

// class StudentMainPage extends StatefulWidget {
//   @override
//   _StudentMainPageState createState() => _StudentMainPageState();
// }

// class _StudentMainPageState extends State<StudentMainPage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     StudentHome(),
//     Student_report(),
//     ProfileScreen(),
//     // Add more pages as needed
//   ];

//   void _onTabSelected(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           AnimatedSwitcher(
//             duration: Duration(milliseconds: 300),
//             child: _pages[_currentIndex],
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: BottomBarView(
//               currentIndex: _currentIndex,
//               onTabSelected: _onTabSelected,
//               tabIconsList: [],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }








import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/student_report.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/pages/custom_page_route.dart'; // Import the custom transition

class StudentMainPage extends StatefulWidget {
  @override
  _StudentMainPageState createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    StudentHome(),
    Student_report(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    final bool slideLeftToRight = _currentIndex > index;

    Navigator.of(context).pushReplacement(CustomPageTransition(
      page: _pages[index],
      slideLeftToRight: slideLeftToRight,
    ));

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomBarView(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
        tabIconsList: [],
      ),
    );
  }
}
