// import 'package:flutter/material.dart';
// import 'my_diary/my_diary_screen.dart';
// import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
// import 'package:lottie/lottie.dart';

// class TabIconData {
//   final IconData icon;
//   bool isSelected;

//   TabIconData(this.icon, this.isSelected);

//   static List<TabIconData> get tabIconsList {
//     return [
//       TabIconData(Icons.home, true),
//       TabIconData(Icons.report, false),
//       TabIconData(Icons.settings, false),
//     ];
//   }
// }

// class StudentHome extends StatefulWidget {
//   @override
//   _StudentHomeState createState() => _StudentHomeState();
// }

// class _StudentHomeState extends State<StudentHome>
//     with TickerProviderStateMixin {
//   AnimationController? animationController;
//   List<TabIconData> tabIconsList = TabIconData.tabIconsList;
//   Widget tabBody = Container(
//     color: Colors.white,
//   );

//   @override
//   void initState() {
//     super.initState();

//     tabIconsList.forEach((TabIconData tab) {
//       tab.isSelected = false;
//     });
//     tabIconsList[0].isSelected = true;

//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 600), vsync: this);
//     tabBody = MyDiaryScreen(animationController: animationController);
//   }

//   @override
//   void dispose() {
//     animationController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: FutureBuilder<bool>(
//           future: getData(),
//           builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//             if (!snapshot.hasData) {
//               return const SizedBox();
//             } else {
//               return Stack(
//                 children: [
//                   // SizedBox(
//                   //   width: MediaQuery.of(context).size.width,
//                   //   child: Lottie.asset(
//                   //     'assets/images/landing/qr_mob.json',
//                   //   ),
//                   // ),
//                   tabBody,
//                   bottomBar(),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     return true;
//   }

//   Widget bottomBar() {
//     return Column(
//       children: <Widget>[
//         const Expanded(
//           child: SizedBox(),
//         ),
//         BottomBarView(
//           currentIndex: tabIconsList.indexWhere((tab) => tab.isSelected),
//           onTabSelected: (int index) {
//             setState(() {
//               for (int i = 0; i < tabIconsList.length; i++) {
//                 tabIconsList[i].isSelected = i == index;
//               }
//             });

//             if (index == 0) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 setState(() {
//                   tabBody =
//                       MyDiaryScreen(animationController: animationController);
//                 });
//               });
//             } else if (index == 1) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 // Set the tab body to your Report screen when the Report tab is clicked.
//                 // tabBody = ReportScreen(); // Replace with your Report screen
//               });
//             } else if (index == 2) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 // Set the tab body to your Settings screen when the Settings tab is clicked.
//                 // tabBody = SettingsScreen(); // Replace with your Settings screen
//               });
//             }
//           },
//           tabIconsList: [],
//         ),
//       ],
//     );
//   }
// }




// import 'dart:ui'; // Import for BackdropFilter
// import 'package:flutter/material.dart';
// import 'my_diary/my_diary_screen.dart';
// import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
// import 'package:lottie/lottie.dart';
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:expandable_datatable/expandable_datatable.dart';
// import 'package:easy_coupon/widgets/components/background.dart';

// class TabIconData {
//   final IconData icon;
//   bool isSelected;

//   TabIconData(this.icon, this.isSelected);

//   static List<TabIconData> get tabIconsList {
//     return [
//       TabIconData(Icons.home, true),
//       TabIconData(Icons.report, false),
//       TabIconData(Icons.settings, false),
//     ];
//   }
// }

// // ignore: camel_case_types
// class StudentHome extends StatefulWidget {
//   const StudentHome({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _StudentHomeState createState() => _StudentHomeState();
// }

// // ignore: camel_case_types
// class _StudentHomeState extends State<StudentHome>
//     with TickerProviderStateMixin {
//   AnimationController? animationController;
//   List<TabIconData> tabIconsList = TabIconData.tabIconsList;
//   Widget tabBody = Container(
//     color: Colors.white,
//   );
//   List<DateTime?> _dates = [DateTime.now()];
//   bool _showTable = false;

 

//   @override
//   void initState() {
//     super.initState();

//     tabIconsList.forEach((TabIconData tab) {
//       tab.isSelected = false;
//     });
//     tabIconsList[0].isSelected = true;

//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 600), vsync: this);

//     // Initial tab body for the report page
//     tabBody = MyDiaryScreen(animationController: animationController);

//   }

 

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             // Background content
//             FutureBuilder<bool>(
//               future: getData(),
//               builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const SizedBox();
//                 } else {
//                   return Positioned(
//                     top: 50,
//                     left: 20,
//                     right: 20,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Hi, Welcome Back!',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF294B29),
//                             fontSize: 25,
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           padding: EdgeInsets.all(8.0),
//                           decoration: BoxDecoration(
//                             color: Color(0xFF789461).withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Expanded(
//                                 child: Text(
//                                   'Select the Range of Dates and Click on "Get Report" to see your Coupon Usage in those Days',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black87,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Transform.scale(
//                                 scale:
//                                     1.5, // Adjust the scale factor to increase the size of the Lottie animation
//                                 child: SizedBox(
//                                   width: 50, // Original size
//                                   height: 50, // Original size
//                                   child: Lottie.asset(
//                                     'assets/images/landing/fetch.json',
//                                     fit: BoxFit.contain,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

                        
//                       ],
//                     ),
//                   );
//                 }
//               },
//             ),
//             if (_showTable) ...[
//               // Blurred background
//               Positioned.fill(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//                   child: Container(
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//               ),
             
//             ],
//             bottomBar(),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     return true;
//   }

//   Widget bottomBar() {
//     return Column(
//       children: <Widget>[
//         const Expanded(
//           child: SizedBox(),
//         ),
//         BottomBarView(
//           currentIndex: tabIconsList.indexWhere((tab) => tab.isSelected),
//           onTabSelected: (int index) {
//             setState(() {
//               for (int i = 0; i < tabIconsList.length; i++) {
//                 tabIconsList[i].isSelected = i == index;
//               }
//             });

//             if (index == 0) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 setState(() {
//                   tabBody =
//                       MyDiaryScreen(animationController: animationController);
//                 });
//               });
//             } else if (index == 1) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 tabBody =
//                     StudentHome(); // Switch to the report screen itself
//               });
//             } else if (index == 2) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 // Set the tab body to your Settings screen when the Settings tab is clicked.
//                 // tabBody = SettingsScreen(); // Replace with your Settings screen
//               });
//             }
//           },
//           tabIconsList: [],
//         ),
//       ],
//     );
//   }
// }



// import 'dart:ui'; // Import for BackdropFilter
// import 'package:flutter/material.dart';
// import 'my_diary/my_diary_screen.dart';
// import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
// import 'package:lottie/lottie.dart';
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:expandable_datatable/expandable_datatable.dart';
// import 'package:easy_coupon/widgets/components/background.dart';

// class TabIconData {
//   final IconData icon;
//   bool isSelected;

//   TabIconData(this.icon, this.isSelected);

//   static List<TabIconData> get tabIconsList {
//     return [
//       TabIconData(Icons.home, true),
//       TabIconData(Icons.report, false),
//       TabIconData(Icons.settings, false),
//     ];
//   }
// }

// // ignore: camel_case_types
// class StudentHome extends StatefulWidget {
//   const StudentHome({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _StudentHomeState createState() => _StudentHomeState();
// }

// // ignore: camel_case_types
// class _StudentHomeState extends State<StudentHome>
//     with TickerProviderStateMixin {
//   AnimationController? animationController;
//   List<TabIconData> tabIconsList = TabIconData.tabIconsList;
//   Widget tabBody = Container(
//     color: Colors.white,
//   );
//   List<DateTime?> _dates = [DateTime.now()];
//   bool _showTable = false;

//   @override
//   void initState() {
//     super.initState();

//     tabIconsList.forEach((TabIconData tab) {
//       tab.isSelected = false;
//     });
//     tabIconsList[0].isSelected = true;

//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 600), vsync: this);

//     // Initial tab body for the report page
//     tabBody = MyDiaryScreen(animationController: animationController);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         extendBody: true, // Allow the body to extend behind the bottom navigation bar
//         body: Stack(
//           children: [
//             FutureBuilder<bool>(
//               future: getData(),
//               builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const SizedBox();
//                 } else {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 60), // Padding to avoid overlap
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 50),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Text(
//                               'Hi, Welcome Back!',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF294B29),
//                                 fontSize: 25,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Container(
//                               padding: EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF789461).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       'Select the Number of Coupons and Scan the QR Code to get your Meal',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Transform.scale(
//                                     scale:
//                                         1.7, // Adjust the scale factor to increase the size of the Lottie animation
//                                     child: SizedBox(
//                                       width: 40, // Original size
//                                       height: 40, // Original size
//                                       child: Lottie.asset(
//                                         'assets/images/landing/qr_h.json',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Additional content...
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//             // 
//           ],
//         ),
//         bottomNavigationBar: BottomBarView(
//           currentIndex: tabIconsList.indexWhere((tab) => tab.isSelected),
//           onTabSelected: (int index) {
//             setState(() {
//               for (int i = 0; i < tabIconsList.length; i++) {
//                 tabIconsList[i].isSelected = i == index;
//               }
//             });

//             if (index == 0) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 setState(() {
//                   tabBody =
//                       MyDiaryScreen(animationController: animationController);
//                 });
//               });
//             } else if (index == 1) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 tabBody =
//                     StudentHome(); // Switch to the report screen itself
//               });
//             } else if (index == 2) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 // Set the tab body to your Settings screen when the Settings tab is clicked.
//                 // tabBody = SettingsScreen(); // Replace with your Settings screen
//               });
//             }
//           },
//           tabIconsList: [],
//         ),
//       ),
//     );
//   }

//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     return true;
//   }
// }














// import 'package:flutter/material.dart';
// import 'my_diary/my_diary_screen.dart';
// import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
// import 'package:lottie/lottie.dart';
// import 'package:easy_coupon/widgets/components/background.dart';
// import 'package:easy_coupon/widgets/common/segment.dart'; // Import your DonutChart widget

// class TabIconData {
//   final IconData icon;
//   bool isSelected;

//   TabIconData(this.icon, this.isSelected);

//   static List<TabIconData> get tabIconsList {
//     return [
//       TabIconData(Icons.home, true),
//       TabIconData(Icons.report, false),
//       TabIconData(Icons.settings, false),
//     ];
//   }
// }

// // ignore: camel_case_types
// class StudentHome extends StatefulWidget {
//   const StudentHome({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _StudentHomeState createState() => _StudentHomeState();
// }

// // ignore: camel_case_types
// class _StudentHomeState extends State<StudentHome>
//     with TickerProviderStateMixin {
//   AnimationController? animationController;
//   List<TabIconData> tabIconsList = TabIconData.tabIconsList;
//   Widget tabBody = Container(
//     color: Colors.white,
//   );
//   List<DateTime?> _dates = [DateTime.now()];
//   bool _showTable = false;
//   int _selectedCoupons = 1; // Variable to track the selected number of coupons

//   @override
//   void initState() {
//     super.initState();

//     tabIconsList.forEach((TabIconData tab) {
//       tab.isSelected = false;
//     });
//     tabIconsList[0].isSelected = true;

//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 600), vsync: this);

//     // Initial tab body for the report page
//     tabBody = MyDiaryScreen(animationController: animationController);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         extendBody: true, // Allow the body to extend behind the bottom navigation bar
//         body: Stack(
//           children: [
//             FutureBuilder<bool>(
//               future: getData(),
//               builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                 if (!snapshot.hasData) {
//                   return const SizedBox();
//                 } else {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 60), // Padding to avoid overlap
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 50),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Text(
//                               'Hi, Welcome Back!',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF294B29),
//                                 fontSize: 25,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: Container(
//                               padding: EdgeInsets.all(8.0),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFF789461).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Expanded(
//                                     child: Text(
//                                       'Select the Number of Coupons and Scan the QR Code to get your Meal',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.black87,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Transform.scale(
//                                     scale:
//                                         1.7, // Adjust the scale factor to increase the size of the Lottie animation
//                                     child: SizedBox(
//                                       width: 40, // Original size
//                                       height: 40, // Original size
//                                       child: Lottie.asset(
//                                         'assets/images/landing/qr_h.json',
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20), // Add spacing before the donut chart
//                           Center(
//                             child: DonutChart(
//                               animation: animationController!, // Pass the animation controller
//                             ),
//                           ),
//                           SizedBox(height: 20), // Add spacing before the spin box
//                           Center(
//                             child: Column(
//                               children: [
//                                 Text(
//                                   'Select number of coupons',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF294B29),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     IconButton(
//                                       icon: Icon(Icons.remove),
//                                       onPressed: () {
//                                         setState(() {
//                                           if (_selectedCoupons > 1) {
//                                             _selectedCoupons--;
//                                           }
//                                         });
//                                       },
//                                     ),
//                                     Text(
//                                       '$_selectedCoupons',
//                                       style: TextStyle(
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.bold,
//                                         color: Color(0xFF294B29),
//                                       ),
//                                     ),
//                                     IconButton(
//                                       icon: Icon(Icons.add),
//                                       onPressed: () {
//                                         setState(() {
//                                           if (_selectedCoupons < 3) {
//                                             _selectedCoupons++;
//                                           }
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//         bottomNavigationBar: BottomBarView(
//           currentIndex: tabIconsList.indexWhere((tab) => tab.isSelected),
//           onTabSelected: (int index) {
//             setState(() {
//               for (int i = 0; i < tabIconsList.length; i++) {
//                 tabIconsList[i].isSelected = i == index;
//               }
//             });

//             if (index == 0) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 setState(() {
//                   tabBody =
//                       MyDiaryScreen(animationController: animationController);
//                 });
//               });
//             } else if (index == 1) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 tabBody =
//                     StudentHome(); // Switch to the report screen itself
//               });
//             } else if (index == 2) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 // Set the tab body to your Settings screen when the Settings tab is clicked.
//                 // tabBody = SettingsScreen(); // Replace with your Settings screen
//               });
//             }
//           },
//           tabIconsList: [],
//         ),
//       ),
//     );
//   }

//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 200));
//     return true;
//   }
// }















import 'package:flutter/material.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/components/background.dart';
import 'package:easy_coupon/widgets/common/segment.dart'; // Import your DonutChart widget

class TabIconData {
  final IconData icon;
  bool isSelected;

  TabIconData(this.icon, this.isSelected);

  static List<TabIconData> get tabIconsList {
    return [
      TabIconData(Icons.home, true),
      TabIconData(Icons.report, false),
      TabIconData(Icons.settings, false),
    ];
  }
}

// ignore: camel_case_types
class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentHomeState createState() => _StudentHomeState();
}

// ignore: camel_case_types
class _StudentHomeState extends State<StudentHome>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(
    color: Colors.white,
  );
  List<DateTime?> _dates = [DateTime.now()];
  bool _showTable = false;
  int _selectedCoupons = 1; // Variable to track the selected number of coupons

  @override
  void initState() {
    super.initState();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    // Initial tab body for the report page
    tabBody = MyDiaryScreen(animationController: animationController);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double padding = 40; // Adjust this value according to your padding
    final double containerWidth = screenWidth - padding * 2; // Width for the spinbox container

    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true, // Allow the body to extend behind the bottom navigation bar
        body: Stack(
          children: [
            FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 60), // Padding to avoid overlap
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Hi, Welcome Back!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF294B29),
                                fontSize: 25,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Color(0xFF789461).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Select the Number of Coupons and Scan the QR Code to get your Meal',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Transform.scale(
                                    scale: 1.7, // Adjust the scale factor to increase the size of the Lottie animation
                                    child: SizedBox(
                                      width: 40, // Original size
                                      height: 40, // Original size
                                      child: Lottie.asset(
                                        'assets/images/landing/qr_h.json',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20), // Add spacing before the donut chart
                          Center(
                            child: DonutChart(
                              animation: animationController!, // Pass the animation controller
                            ),
                          ),
                          SizedBox(height: 20), // Add spacing before the spin box
                          Center(
                            child: Container(
                              width: containerWidth, // Set width of the spinbox container
                              decoration: BoxDecoration(
                                color: Color(0xFF789461), // Green background color
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              padding: EdgeInsets.all(8.0), // Reduce padding to decrease height
                              child: Column(
                                children: [
                                  Text(
                                    'Select number of coupons',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Text color is black
                                    ),
                                  ),
                                  SizedBox(height: 8), // Reduced spacing
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove, color: Colors.white), // White icons for better visibility
                                        onPressed: () {
                                          setState(() {
                                            if (_selectedCoupons > 1) {
                                              _selectedCoupons--;
                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        '$_selectedCoupons',
                                        style: TextStyle(
                                          fontSize: 20, // Smaller font size
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white, // Text color is white for contrast
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add, color: Colors.white), // White icons for better visibility
                                        onPressed: () {
                                          setState(() {
                                            if (_selectedCoupons < 3) {
                                              _selectedCoupons++;
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomBarView(
          currentIndex: tabIconsList.indexWhere((tab) => tab.isSelected),
          onTabSelected: (int index) {
            setState(() {
              for (int i = 0; i < tabIconsList.length; i++) {
                tabIconsList[i].isSelected = i == index;
              }
            });

            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                tabBody =
                    StudentHome(); // Switch to the report screen itself
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                // Set the tab body to your Settings screen when the Settings tab is clicked.
                // tabBody = SettingsScreen(); // Replace with your Settings screen
              });
            }
          },
          tabIconsList: [],
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
