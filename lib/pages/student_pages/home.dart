//import 'package:best_flutter_ui_templates/fitness_app/training/training_screen.dart';
import 'package:flutter/material.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:easy_coupon/pages/student_pages/models/tablecon_data.dart';
//import 'package:easy_coupon/pages/student_pages/trainig/trainind_screen.dart';
import 'package:lottie/lottie.dart';

class Student_home extends StatefulWidget {
  @override
  _Student_homeState createState() => _Student_homeState();
}

class _Student_homeState extends State<Student_home>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: StudentTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: StudentTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: [
                SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Lottie.asset(
                  'assets/images/landing/qr_mob.json',
                  // fit: BoxFit.contain,
                ),
              ),

                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                // setState(() {
                //   tabBody =
                //       TrainingScreen(animationController: animationController);
                // });
              });
            }
          },
        ),
      ],
    );
  }



}




// import 'package:flutter/material.dart';
// import 'my_diary/my_diary_screen.dart';
// import 'package:lottie/lottie.dart';
// import 'package:easy_coupon/widgets/widgets.dart';

// class StudentHome extends StatefulWidget {
//   @override
//   _StudentHomeState createState() => _StudentHomeState();
// }

// class _StudentHomeState extends State<StudentHome> with TickerProviderStateMixin {
//   AnimationController? animationController;
//   Widget tabBody = Container(
//     color: StudentTheme.background,
//   );

//   int currentIndex = 0;
//   final PageController _pageController = PageController();

//   @override
//   void initState() {
//     animationController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     tabBody = MyDiaryScreen(animationController: animationController);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     animationController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: StudentTheme.background,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width,
//               child: Lottie.asset(
//                 'assets/images/landing/qr_mob.json',
//               ),
//             ),
//             PageView(
//               controller: _pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentIndex = index;
//                 });
//               },
//               children: [
//                 MyDiaryScreen(animationController: animationController), // Home
//                 Center(child: Text('Report')), // Report Page
//                 Center(child: Text('Settings')), // Settings Page
//               ],
//             ),
//             bottomBar(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget bottomBar() {
//     return Column(
//       children: <Widget>[
//         const Expanded(
//           child: SizedBox(),
//         ),
//         AnimatedNotchBottomBar(
//           notchColor: Colors.blue,
//           items: [
//             BottomBarItem(
//               inActiveItem: Icon(
//                 Icons.home_filled,
//                 color: Colors.black,
//               ),
//               activeItem: Icon(
//                 Icons.home_filled,
//                 color: Colors.blue,
//               ),
//               itemLabel: 'Home',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(
//                 Icons.report,
//                 color: Colors.black,
//               ),
//               activeItem: Icon(
//                 Icons.report,
//                 color: Colors.blue,
//               ),
//               itemLabel: 'Report',
//             ),
//             BottomBarItem(
//               inActiveItem: Icon(
//                 Icons.settings,
//                 color: Colors.black,
//               ),
//               activeItem: Icon(
//                 Icons.settings,
//                 color: Colors.blue,
//               ),
//               itemLabel: 'Settings',
//             ),
//           ],
//           onTap: (index) {
//             setState(() {
//               currentIndex = index;
//               _pageController.animateToPage(
//                 index,
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeIn,
//               );
//             });
//           },
//         ),
//       ],
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';


// class StudentHome extends StatefulWidget {
//   const StudentHome({Key? key}) : super(key: key);

//   @override
//   _StudentHomeState createState() => _StudentHomeState();
// }

// class _StudentHomeState extends State<StudentHome> with TickerProviderStateMixin {
//   late final AnimationController _animationController;
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;

//   final List<Widget> _pages = [
//     // Replace these with your actual pages
//     MyDiaryScreen(),
//     ReportScreen(),
//     SettingsScreen(),
//   ];

//   final List<BottomBarItem> _bottomBarItems = [
//     BottomBarItem(
//       inActiveItem: const Icon(
//         Icons.home_filled,
//         color: Colors.grey,
//       ),
//       activeItem: const Icon(
//         Icons.home_filled,
//         color: Colors.blue,
//       ),
//       itemLabel: 'Home',
//     ),
//     BottomBarItem(
//       inActiveItem: const Icon(
//         Icons.report,
//         color: Colors.grey,
//       ),
//       activeItem: const Icon(
//         Icons.report,
//         color: Colors.blue,
//       ),
//       itemLabel: 'Report',
//     ),
//     BottomBarItem(
//       inActiveItem: const Icon(
//         Icons.settings,
//         color: Colors.grey,
//       ),
//       activeItem: const Icon(
//         Icons.settings,
//         color: Colors.blue,
//       ),
//       itemLabel: 'Settings',
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // Background Animation
//       body: Stack(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Lottie.asset(
//               'assets/images/landing/qr_mob.json',
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Page View
//           PageView(
//             controller: _pageController,
//             physics: const NeverScrollableScrollPhysics(), // Disable swipe
//             children: _pages,
//           ),
//         ],
//       ),
//       // Bottom Navigation Bar
//       bottomNavigationBar: AnimatedNotchBottomBar(
//         notchColor: Colors.white,
//         color: Colors.white,
//         showLabel: true,
//         itemLabelStyle: const TextStyle(
//           color: Colors.blue,
//           fontWeight: FontWeight.w500,
//         ),
//         pageController: _pageController,
//         bottomBarItems: _bottomBarItems,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           _pageController.animateToPage(
//             index,
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           );
//         },
//       ),
//     );
//   }
// }

// // Placeholder Widgets for Screens
// class MyDiaryScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('My Diary Screen'));
//   }
// }

// class ReportScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Report Screen'));
//   }
// }

// class SettingsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('Settings Screen'));
//   }
// }
