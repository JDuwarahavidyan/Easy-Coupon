import 'package:easy_coupon/pages/canteen_a_pages/canteen_a_report.dart';
import 'package:easy_coupon/pages/canteen_a_pages/canteen_profile.dart';
import 'package:easy_coupon/pages/pages.dart';
// import 'package:easy_coupon/pages/student_pages/student_report.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CanteenMainPage extends StatefulWidget {
  final int currentIndex;
  const CanteenMainPage({super.key, this.currentIndex = 0});

  @override
  _CanteenMainPageState createState() => _CanteenMainPageState();
}

class _CanteenMainPageState extends State<CanteenMainPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  final List<Widget> _pages = [
    CanteenAHome(),
    CanteenAReport(),
    CanteenProfileScreen(),
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
