import 'dart:ui'; // Import for BackdropFilter
import 'package:easy_coupon/pages/student_pages/student_home.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_coupon/widgets/common/background.dart';

class TabIconData {
  final IconData icon;
  bool isSelected;

  TabIconData(this.icon, this.isSelected);

  static List<TabIconData> get tabIconsList {
    return [
      TabIconData(Icons.home, false),
      TabIconData(Icons.report, true),
      TabIconData(Icons.settings, false),
    ];
  }
}

class Student_report extends StatefulWidget {
  const Student_report({super.key});

  @override
  _Student_reportState createState() => _Student_reportState();
}

class _Student_reportState extends State<Student_report>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(
    color: Colors.white,
  );
  List<DateTime?> _dates = [DateTime.now()];
  bool _showTable = false;

  // Updated dummy data for the table
  final List<Map<String, dynamic>> dummyData = List.generate(
      10,
      (index) => {
            "Date and Time": "2024-08-02 14:00",
            "Canteen": "Canteen B",
            "Coupons Used": 90,
          });

  late final List<DataColumn> headers = [
    const DataColumn(
      label: Center(
        child: Text(
          "Date and Time",
          style: _headerStyle,
        ),
      ),
    ),
    const DataColumn(
      label: Center(
        child: Text(
          "Canteen",
          style: _headerStyle,
        ),
      ),
    ),
    const DataColumn(
      label: Center(
        child: Text(
          "Coupons Used",
          style: _headerStyle,
        ),
      ),
    ),
  ];

  late final List<DataRow> rows = dummyData.map<DataRow>((data) {
    bool isEven = dummyData.indexOf(data) % 2 == 0;
    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        return isEven ? const Color(0xFFDBE7C9) : const Color(0xFFDBE7C9);
      }),
      cells: [
        DataCell(Center(child: Text(data["Date and Time"], style: _cellStyle))),
        DataCell(Center(child: Text(data["Canteen"], style: _cellStyle))),
        DataCell(Center(
            child: Text(data["Coupons Used"].toString(), style: _cellStyle))),
      ],
    );
  }).toList();

  static const TextStyle _headerStyle =
      TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black);

  static const TextStyle _cellStyle = TextStyle(
      fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black);

  @override
  void initState() {
    super.initState();
    tabIconsList[1].isSelected = true;
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = StudentHome(animationController: animationController);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _fetchData() {
    setState(() {
      _showTable = true; // Show the table when the Fetch button is pressed
    });
  }

  void _closeTable() {
    setState(() {
      _showTable = false; // Hide the table when the close button is pressed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              decoration: BoxDecoration(
                color: Color(0xFFDBE7C9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Report Page",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF294B29),
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder<bool>(
              future: getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const SizedBox();
                return Positioned(
                  top: 100,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
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
                                'Select the Range of Dates and Click on "Get Report" to see your Coupon Usage in those Days',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Transform.scale(
                              scale: 1.5,
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Lottie.asset(
                                  'assets/images/landing/fetch.json',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.range,
                          selectedDayHighlightColor: Color(0xFF789461),
                          dayTextStyle: const TextStyle(color: Colors.blue),
                          selectedDayTextStyle:
                              const TextStyle(color: Colors.white),
                        ),
                        value: _dates,
                        onValueChanged: (dates) => setState(() {
                          _dates = dates;
                        }),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          onPressed: _fetchData,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                            padding: EdgeInsets.zero,
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            backgroundColor: Color(0xFF294B29),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            height: 50.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.0),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF294B29),
                                  Color(0xFF50623A),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(0),
                            child: const Text(
                              "GET REPORT",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (_showTable) ...[
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 20,
                right: 20,
                bottom: 100,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10.0)
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Results',
                              style: Theme.of(context).textTheme.titleLarge),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: _closeTable,
                          ),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            columnSpacing: 12,
                            columns: headers,
                            rows: rows,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            bottomBar(),
          ],
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
                    const Student_report(); // Switch to the report screen itself
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
      ],
    );
  }
}
// import 'dart:ui'; // Import for BackdropFilter
// import 'package:easy_coupon/pages/student_pages/student_home.dart';
// import 'package:easy_coupon/pages/pages.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
// import 'package:lottie/lottie.dart';
// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:easy_coupon/widgets/common/background.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:easy_coupon/bloc/qr/qr_bloc.dart';
// import 'package:easy_coupon/bloc/user/user_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:easy_coupon/services/report/report_service.dart';
// import 'package:easy_coupon/models/student.dart';
// import 'package:intl/intl.dart';

// class TabIconData {
//   final IconData icon;
//   bool isSelected;

//   TabIconData(this.icon, this.isSelected);

//   static List<TabIconData> get tabIconsList {
//     return [
//       TabIconData(Icons.home, false),
//       TabIconData(Icons.report, true),
//       TabIconData(Icons.settings, false),
//     ];
//   }
// }

// class Student_report extends StatefulWidget {
//   const Student_report({super.key});

//   @override
//   _Student_reportState createState() => _Student_reportState();
// }

// class _Student_reportState extends State<Student_report>
//     with TickerProviderStateMixin {
//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();

//   AnimationController? animationController;
//   List<TabIconData> tabIconsList = TabIconData.tabIconsList;
//   Widget tabBody = Container(
//     color: Colors.white,
//   );
//   List<DateTime?> _dates = [DateTime.now()];
//   bool _showTable = false;

//   // Updated dummy data for the table
//   // final List<Map<String, dynamic>> dummyData = List.generate(
//   //     10,
//   //     (index) => {
//   //           "Date and Time": "2024-08-02 14:00",
//   //           "Canteen": "Canteen B",
//   //           "Coupons Used": 90,
//   //         });

//   // late final List<DataColumn> headers = [
//   //   const DataColumn(
//   //     label: Center(
//   //       child: Text(
//   //         "Date and Time",
//   //         style: _headerStyle,
//   //       ),
//   //     ),
//   //   ),
//   //   const DataColumn(
//   //     label: Center(
//   //       child: Text(
//   //         "Canteen",
//   //         style: _headerStyle,
//   //       ),
//   //     ),
//   //   ),
//   //   const DataColumn(
//   //     label: Center(
//   //       child: Text(
//   //         "Coupons Used",
//   //         style: _headerStyle,
//   //       ),
//   //     ),
//   //   ),
//   // ];

//   // late final List<DataRow> rows = dummyData.map<DataRow>((data) {
//   //   bool isEven = dummyData.indexOf(data) % 2 == 0;
//   //   return DataRow(
//   //     color: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
//   //       return isEven ? const Color(0xFFDBE7C9) : const Color(0xFFDBE7C9);
//   //     }),
//   //     cells: [
//   //       DataCell(Center(child: Text(data["Date and Time"], style: _cellStyle))),
//   //       DataCell(Center(child: Text(data["Canteen"], style: _cellStyle))),
//   //       DataCell(Center(
//   //           child: Text(data["Coupons Used"].toString(), style: _cellStyle))),
//   //     ],
//   //   );
//   // }).toList();
//   late List<DataRow> rows = [];

// // Dummy data for canteen and coupons used
//   // final List<Map<String, dynamic>> dummyData = [
//   //   {"Canteen": "Canteen B", "Coupons Used": 90},
//   // ];

// // Define headers
//   late final List<DataColumn> headers = [
//     const DataColumn(
//       label: Center(
//         child: Text(
//           "Date and Time",
//           style: _headerStyle,
//         ),
//       ),
//     ),
//     const DataColumn(
//       label: Center(
//         child: Text(
//           "Canteen",
//           style: _headerStyle,
//         ),
//       ),
//     ),
//     const DataColumn(
//       label: Center(
//         child: Text(
//           "Coupons Used",
//           style: _headerStyle,
//         ),
//       ),
//     ),
//   ];

//   static const TextStyle _headerStyle =
//       TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black);

//   static const TextStyle _cellStyle = TextStyle(
//       fontSize: 10, fontWeight: FontWeight.normal, color: Colors.black);

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserQrCodes();
//     tabIconsList[1].isSelected = true;
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 600), vsync: this);
//     tabBody = StudentHome(animationController: animationController);
//   }

//   void _fetchUserQrCodes({DateTime? startDate, DateTime? endDate}) {
//     final currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       context.read<QrCodeBloc>().add(LoadQrCodesByUid(currentUser.uid,
//           startDate: startDate,
//           endDate: endDate,
//           reportType: 'student_report'));
//     }
//   }

//   @override
//   void dispose() {
//     animationController?.dispose();
//     super.dispose();
//   }

//   void _fetchData() async {
    
//       // Check if both start and end dates are selected
//       if (_dates[0] != null && _dates[1] != null) {
//         // Generate the dates between the selected start and end dates
//         String startDate = DateFormat('yyyy-MM-dd').format(_dates[0]!);
//         String endDate = DateFormat('yyyy-MM-dd').format(_dates[1]!);

//         List<ReportDataModel> reportData = await ReportService().fetchReportData(
//         startDate: DateTime.parse(startDate),
//         endDate: DateTime.parse(endDate),
//       );

//       setState(() {
//         rows = reportData.map<DataRow>((data) {
//           return DataRow(
//             cells: [
//               DataCell(Center(child: Text(data.scannedAt, style: _cellStyle))),
//               DataCell(Center(child: Text(data.canteenName, style: _cellStyle))),
//               DataCell(
//                 Center(
//                     child:
//                         Text(data.count.toString(), style: _cellStyle)),
//               ),
//             ],
//           );
//         }).toList();
//         _showTable = true; // Show the table when the Fetch button is pressed
//       });
//       }
//       }
// // Function to generate a list of dates between start and end dates
//   List<String> _generateDateRange(DateTime start, DateTime end) {
//     List<String> dates = [];
//     for (var date = start;
//         date.isBefore(end) || date.isAtSameMomentAs(end);
//         date = date.add(Duration(days: 1))) {
//       dates.add("${date.toLocal()}".split(' ')[0] +
//           " 00:00"); // Format: YYYY-MM-DD HH:MM
//     }
//     return dates;
//   }

//   void _closeTable() {
//     setState(() {
//       _showTable = false; // Hide the table when the close button is pressed
//     });
//   }

//   Future<void> _selectDate(
//       BuildContext context, TextEditingController controller) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: Color(0xFFFF8A00),
//               onPrimary: Colors.white,
//               onSurface: Colors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: const Color(0xFFFF8A00),
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (pickedDate != null) {
//       setState(() {
//         controller.text = "${pickedDate.toLocal()}".split(' ')[0];
//       });
//       // Fetch QR codes with selected date range
//       final startDate = _startDateController.text.isNotEmpty
//           ? DateTime.parse(_startDateController.text)
//           : null;
//       final endDate = _endDateController.text.isNotEmpty
//           ? DateTime.parse(_endDateController.text)
//           : null;
//       _fetchUserQrCodes(startDate: startDate, endDate: endDate);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Stack(
//           children: [
//             Container(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//               decoration: BoxDecoration(
//                 color: Color(0xFFDBE7C9),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     offset: Offset(0, 2),
//                     blurRadius: 4,
//                   ),
//                 ],
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Report Page",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF294B29),
//                         fontSize: 25,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             FutureBuilder<bool>(
//               future: getData(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) return const SizedBox();
//                 return Positioned(
//                   top: 100,
//                   left: 20,
//                   right: 20,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 10),
//                       Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF789461).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Expanded(
//                               child: Text(
//                                 'Select the Range of Dates and Click on "Get Report" to see your Coupon Usage in those Days',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.black87,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 10),
//                             Transform.scale(
//                               scale: 1.5,
//                               child: SizedBox(
//                                 width: 50,
//                                 height: 50,
//                                 child: Lottie.asset(
//                                   'assets/images/landing/fetch.json',
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       CalendarDatePicker2(
//                         config: CalendarDatePicker2Config(
//                           calendarType: CalendarDatePicker2Type.range,
//                           selectedDayHighlightColor: Color(0xFF789461),
//                           dayTextStyle: const TextStyle(color: Colors.blue),
//                           selectedDayTextStyle:
//                               const TextStyle(color: Colors.white),
//                         ),
//                         value: _dates,
//                         onValueChanged: (dates) => setState(() {
//                           _dates = dates;
//                           if (_dates[0] != null && _dates[1] != null) {
//                             _fetchUserQrCodes(
//                                 startDate: _dates[0], endDate: _dates[1]);
//                           }
//                         }),
//                       ),
//                       const SizedBox(height: 10),
//                       Center(
//                         child: ElevatedButton(
//                           onPressed: _fetchData,
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(80.0),
//                             ),
//                             padding: EdgeInsets.zero,
//                             textStyle: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             backgroundColor: Color(0xFF294B29),
//                           ),
//                           child: Container(
//                             alignment: Alignment.center,
//                             height: 50.0,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(80.0),
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color(0xFF294B29),
//                                   Color(0xFF50623A),
//                                 ],
//                               ),
//                             ),
//                             padding: const EdgeInsets.all(0),
//                             child: const Text(
//                               "GET REPORT",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//             if (_showTable) ...[
//               Positioned.fill(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
//                   child: Container(
//                     color: Colors.black.withOpacity(0.5),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 100,
//                 left: 20,
//                 right: 20,
//                 bottom: 100,
//                 child: Container(
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.0),
//                     boxShadow: [
//                       BoxShadow(color: Colors.black26, blurRadius: 10.0)
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Results',
//                               style: Theme.of(context).textTheme.titleLarge),
//                           IconButton(
//                             icon: Icon(Icons.close),
//                             onPressed: _closeTable,
//                           ),
//                         ],
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: DataTable(
//                             columnSpacing: 12,
//                             columns: headers,
//                             rows: rows,
//                           ),
//                         ),
//                       ),
//                     ],
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
//                       StudentHome(animationController: animationController);
//                 });
//               });
//             } else if (index == 1) {
//               animationController?.reverse().then<dynamic>((data) {
//                 if (!mounted) {
//                   return;
//                 }
//                 tabBody =
//                     const Student_report(); // Switch to the report screen itself
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
