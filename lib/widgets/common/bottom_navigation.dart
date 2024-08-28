import 'package:easy_coupon/pages/student_pages/report.dart';
import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class BottomBarView extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  BottomBarView({
    required this.currentIndex,
    required this.onTabSelected,
    required List<TabIconData> tabIconsList,
  });

  @override
  Widget build(BuildContext context) {
    return BottomBar(
      selectedIndex: currentIndex,
      onTap: (index) {
        onTabSelected(index);
      },
      items: const [
        BottomBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
          activeColor: Color(0xFF789461),
        ),
        BottomBarItem(
          icon: Icon(Icons.bar_chart),
          title: Text('Report'),
          activeColor: Color(0xFF789461),
        ),
        BottomBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Color(0xFF789461),
        ),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:bottom_bar/bottom_bar.dart';

// class BottomBarView extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTabSelected;

//   BottomBarView({
//     required this.currentIndex,
//     required this.onTabSelected,
//   });

//   @override
//   _BottomBarViewState createState() => _BottomBarViewState();
// }

// class _BottomBarViewState extends State<BottomBarView> {
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: widget.currentIndex);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           widget.onTabSelected(index);
//         },
//         children: const [
//           StudentHome(),
//           ReportPage(),
//           SettingsPage(),
//         ],
//       ),
//       bottomNavigationBar: BottomBar(
//         selectedIndex: widget.currentIndex,
//         onTap: (index) {
//           widget.onTabSelected(index);
//           _pageController.jumpToPage(index);
//         },
//         items: const [
//           BottomBarItem(
//             icon: Icon(Icons.home),
//             title: Text('Home'),
//             activeColor: Color(0xFF294B29),
//           ),
//           BottomBarItem(
//             icon: Icon(Icons.bar_chart),
//             title: Text('Report'),
//             activeColor: Color(0xFF294B29),
//           ),
//           BottomBarItem(
//             icon: Icon(Icons.settings),
//             title: Text('Settings'),
//             activeColor: Color(0xFF294B29),
//           ),
//         ],
//       ),
//     );
//   }
// }
