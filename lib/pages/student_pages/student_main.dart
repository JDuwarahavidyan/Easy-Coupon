import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/student_report.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StudentMainPage extends StatefulWidget {
  final int currentIndex;

  StudentMainPage({this.currentIndex = 0});

  @override
  // ignore: library_private_types_in_public_api
  _StudentMainPageState createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  final List<Widget> _pages = [
    const StudentHome(),
    const Student_report(),
    const ProfileScreen(),
    
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
            duration: const Duration(milliseconds: 300),
            child: _pages[_currentIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomBarView(
              currentIndex: _currentIndex,
              onTabSelected: _onTabSelected,
              tabIconsList: const [],
            ),
          ),
        ],
      ),
    );
  }
}
