// import 'package:easy_coupon/pages/student_pages/student_report.dart';
// import 'package:flutter/material.dart';
// import 'package:bottom_bar/bottom_bar.dart';

// class BottomBarView extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabSelected;

//   BottomBarView({
//     required this.currentIndex,
//     required this.onTabSelected,
//     required List<TabIconData> tabIconsList,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BottomBar(
//       selectedIndex: currentIndex,
//       onTap: (index) {
//         onTabSelected(index);
//       },
//       items: const [
//         BottomBarItem(
//           icon: Icon(Icons.home),
//           title: Text('Home'),
//           activeColor: Color(0xFF789461),
//         ),
//         BottomBarItem(
//           icon: Icon(Icons.bar_chart),
//           title: Text('Report'),
//           activeColor: Color(0xFF789461),
//         ),
//         BottomBarItem(
//           icon: Icon(Icons.settings),
//           title: Text('Settings'),
//           activeColor: Color(0xFF789461),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class BottomBarView extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  BottomBarView({
    required this.currentIndex,
    required this.onTabSelected, required List tabIconsList,
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
          activeColor: Color(0xFF000000),
        ),
        BottomBarItem(
          icon: Icon(Icons.bar_chart),
          title: Text('Report'),
          activeColor: Color(0xFF000000),
        ),
        BottomBarItem(
          icon: Icon(Icons.settings),
          title: Text('Settings'),
          activeColor: Color(0xFF000000),
        ),
      ],
      backgroundColor: Colors.transparent, // Set the background color to transparent
      height: 65,
    );
  }
}





// import 'package:easy_coupon/pages/student_pages/student_report.dart';
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// class BottomBarView extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTabSelected;
//   final Function() addClick;
//   final Function(int) changeIndex;
//   final int selectedIndex;

//   BottomBarView({
//     required this.currentIndex,
//     required this.onTabSelected,
//     required this.addClick,
//     required this.changeIndex,
//     required this.selectedIndex, required List<TabIconData> tabIconsList,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CurvedNavigationBar(
//       index: currentIndex,
//       onTap: (index) {
//         onTabSelected(index);
//         changeIndex(index);  // Call the changeIndex function when a tab is selected
//       },
//       items: <Widget>[
//         Icon(Icons.home, size: 30, color: Color(0xFF789461)),
//         Icon(Icons.bar_chart, size: 30, color: Color(0xFF789461)),
//         Icon(Icons.settings, size: 30, color: Color(0xFF789461)),
//         Icon(Icons.add, size: 30, color: Color(0xFF789461)), // This is an example of an 'add' button
//       ],
//       color: Colors.white, // Background color of the navigation bar
//       buttonBackgroundColor: Colors.white, // Color of the central button
//       backgroundColor: Colors.transparent, // Transparent background color
//       animationCurve: Curves.easeInOut, // Animation curve for the item change
//       animationDuration: Duration(milliseconds: 300), // Duration of the animation
//     );
//   }
// }
