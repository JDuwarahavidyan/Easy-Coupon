import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/student_report.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'package:easy_coupon/widgets/common/segment_c.dart'; // Import your DonutChart widget
import 'package:flutter/cupertino.dart'; // Import Cupertino icons

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
class CanteenAHome extends StatefulWidget {
  const CanteenAHome({super.key, AnimationController? animationController});

  @override
  // ignore: library_private_types_in_public_api
  _CanteenAHomeState createState() => _CanteenAHomeState();
}

class _CanteenAHomeState extends State<CanteenAHome>
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
    // tabBody = MyDiaryScreen(animationController: animationController);
  }

  @override
  Widget build(BuildContext context) {
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
                              'Welcome Back to Kalderama!',
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
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  children: [
                                    Container(
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
                                              'Click on the button to initiate the process of generating the OR code.',
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
                                    SizedBox(height: 20), // Add spacing before the donut chart
                                    Center(
                                      child: Donut_c_Chart(
                                        animation: animationController!, // Pass the animation controller
                                      ),
                                    ),
                                    SizedBox(height: 20), // Add spacing before the spinbox
                                    Center(
                                      // child: Container(
                                      //   width: constraints.maxWidth, // Set the width to match the text container
                                      //   decoration: BoxDecoration(
                                      //     color: Color(0xFF789461), // Green background color
                                      //     borderRadius: BorderRadius.circular(15.0),
                                      //   ),
                                      //   padding: EdgeInsets.all(8.0), // Reduced padding to decrease height
                                      //   // child: Column(
                                      //     // children: [
                                      //     //   Text(
                                      //     //     'Select number of coupons',
                                      //     //     style: TextStyle(
                                      //     //       fontSize: 16,
                                      //     //       fontWeight: FontWeight.bold,
                                      //     //       color: Colors.black, // Text color is black
                                      //     //     ),
                                      //     //   ),
                                      //     //   SizedBox(height: 5), // Reduced height between the text and spinbox
                                      //     //   Row(
                                      //     //     mainAxisAlignment: MainAxisAlignment.center,
                                      //     //     children: [
                                      //     //       IconButton(
                                      //     //         iconSize: 30, // Decreased icon size to reduce overall height
                                      //     //         icon: Icon(Icons.remove, color: Colors.white), // White icons for better visibility
                                      //     //         onPressed: () {
                                      //     //           setState(() {
                                      //     //             if (_selectedCoupons > 1) {
                                      //     //               _selectedCoupons--;
                                      //     //             }
                                      //     //           });
                                      //     //         },
                                      //     //       ),
                                      //     //       SizedBox(width: 15), // Reduced width between the icon and number
                                      //     //       Text(
                                      //     //         '$_selectedCoupons',
                                      //     //         style: TextStyle(
                                      //     //           fontSize: 24,
                                      //     //           fontWeight: FontWeight.bold,
                                      //     //           color: Colors.white, // Text color is white for contrast
                                      //     //         ),
                                      //     //       ),
                                      //     //       SizedBox(width: 15), // Reduced width between the number and icon
                                      //     //       IconButton(
                                      //     //         iconSize: 30, // Decreased icon size to reduce overall height
                                      //     //         icon: Icon(Icons.add, color: Colors.white), // White icons for better visibility
                                      //     //         onPressed: () {
                                      //     //           setState(() {
                                      //     //             if (_selectedCoupons < 3) {
                                      //     //               _selectedCoupons++;
                                      //     //             }
                                      //     //           });
                                      //     //         },
                                      //     //       ),
                                      //     //     ],
                                      //     //   ),
                                      //     // ],
                                      //   // ),
                                      // ),
                                    ),
                                    SizedBox(height: 20), // Add spacing before the "SCAN ME" button
                                    Center(
                                      child: Container(
                                        width: 250, // Increased width of the "SCAN ME" button
                                        decoration: BoxDecoration(
                                          color: Colors.white, // White background color
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: Color(0xFF789461), // Green border color
                                            width: 2.0,
                                          ),
                                        ),
                                        child: CupertinoButton(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0), // Increased padding for larger button
                                          color: Colors.transparent, // Make the button background transparent
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(CupertinoIcons.qrcode, color: Color(0xFF789461)),
                                              SizedBox(width: 10),
                                              Text(
                                                'GENERATE QR',
                                                style: TextStyle(
                                                  color: Color(0xFF789461), // Green text color
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(
                              context, RouteNames.qr);
                                            // Add your scan QR functionality here
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10), // Add spacing before the Lottie animation
                                    SizedBox(
                                      width: 250, // Set width for Lottie animation
                                      height: 250, // Set height for Lottie animation
                                      child: Lottie.asset(
                                        'assets/images/landing/cook.json',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                );
                              },
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
                      StudentHome(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                tabBody =
                    Student_report(); // Switch to the report screen itself
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