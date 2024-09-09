import 'package:easy_coupon/pages/canteen_a_pages/canteen_a_report.dart';
import 'package:easy_coupon/pages/pages.dart';
// import 'package:easy_coupon/pages/student_pages/student_report.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CanteenMainPage extends StatefulWidget {
  const CanteenMainPage({super.key, int? currentIndex});
  
  @override
  _CanteenMainPageState createState() => _CanteenMainPageState();
}

class _CanteenMainPageState extends State<CanteenMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CanteenAHome(),
    CanteenAReport(),
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