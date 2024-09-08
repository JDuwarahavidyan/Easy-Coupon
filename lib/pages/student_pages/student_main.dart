import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/student_report.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StudentMainPage extends StatefulWidget {
  
  const StudentMainPage({super.key, int? currentIndex});
  
  @override
  _StudentMainPageState createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  int _currentIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _currentIndex = widget.currentIndex;
  // }

  final List<Widget> _pages = [
    StudentHome(),
    Student_report(),
    ProfileScreen(),
    // Add more pages as needed
  ];

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _pages[_currentIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomBarView(
              currentIndex: _currentIndex,
              onTabSelected: _onTabSelected,
              tabIconsList: [],
            ),
          ),
        ],
      ),
    );
  }
}
