import 'dart:ui'; // Import for BackdropFilter
import 'package:easy_coupon/pages/pages.dart';
import 'package:easy_coupon/pages/student_pages/student_home.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:expandable_datatable/expandable_datatable.dart';
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

// ignore: camel_case_types
class Student_report extends StatefulWidget {
  const Student_report({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Student_reportState createState() => _Student_reportState();
}

// ignore: camel_case_types
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
  List<Map<String, dynamic>> dummyData = [
    {
      "Date and Time": "2024-08-01 12:00",
      "Canteen": "Canteen A",
      "Coupons Used": 120
    },
    {
      "Date and Time": "2024-08-02 14:00",
      "Canteen": "Canteen B",
      "Coupons Used": 90
    },
    {
      "Date and Time": "2024-08-02 14:00",
      "Canteen": "Canteen B",
      "Coupons Used": 90
    },
    {
      "Date and Time": "2024-08-02 14:00",
      "Canteen": "Canteen B",
      "Coupons Used": 90
    },
    {
      "Date and Time": "2024-08-02 14:00",
      "Canteen": "Canteen B",
      "Coupons Used": 90
    },
    {
      "Date and Time": "2024-08-02 14:00",
      "Canteen": "Canteen B",
      "Coupons Used": 90
    },
    {
      "Date and Time": "2024-08-02 14:00",
      "Canteen": "Canteen B",
      "Coupons Used": 90
    },
    {
      "Date and Time": "2024-08-02 14:00",
      "Canteen": "Canteen B",
      "Coupons Used": 90
    },
    // Add more dummy data as needed
  ];

  late List<DataColumn> headers;
  late List<DataRow> rows;

  @override
  void initState() {
    super.initState();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[1].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    // Initial tab body for the report page
    tabBody = StudentHome(animationController: animationController);

    // Initialize headers for the table
    headers = [
      const DataColumn(
        label: Center(
          child: Text(
            "Date and Time",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      const DataColumn(
        label: Center(
          child: Text(
            "Canteen",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
      const DataColumn(
        label: Center(
          child: Text(
            "Coupons Used",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ),
    ];

    // Initialize rows for the table with dummy data
    rows = dummyData.map<DataRow>((data) {
      bool isEven = dummyData.indexOf(data) % 2 == 0;
      return DataRow(
        color:
            WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          return isEven
              ? const Color(0xFFDBE7C9)
              : const Color(0xFFDBE7C9); // Row colors
        }),
        cells: [
          DataCell(
            Center(
              child: Text(
                data["Date and Time"],
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                maxLines: 2, // Limit to 2 lines
                overflow: TextOverflow.ellipsis, // Handle overflow
              ),
            ),
          ),
          DataCell(
            Center(
              child: Text(
                data["Canteen"],
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
          ),
          DataCell(
            Center(
              child: Text(
                data["Coupons Used"].toString(),
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      );
    }).toList();
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
            // Background content
            FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Positioned(
                    top: 50,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Report Page',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF294B29),
                            fontSize: 25,
                          ),
                        ),
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
                                scale:
                                    1.5, // Adjust the scale factor to increase the size of the Lottie animation
                                child: SizedBox(
                                  width: 50, // Original size
                                  height: 50, // Original size
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
                            dayTextStyle: const TextStyle(color: Color.fromARGB(255, 40, 53, 52)),
                            selectedDayTextStyle:
                                const TextStyle(color: Colors.white),
                          ),
                          value: _dates,
                          onValueChanged: (dates) {
                            setState(() {
                              _dates = dates;
                            });
                          },
                        ),
                        const SizedBox(
                            height:
                                10), // Adjust this value to move the button closer
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
                              backgroundColor:
                                  Color(0xFF294B29), // Button color
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              // width: size.width,
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
                }
              },
            ),
            if (_showTable) ...[
              // Blurred background
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              // Table popup
              Positioned(
                top: 150, // Adjust this value to position above the navbar
                left: 20,
                right: 20,
                bottom: 60, // Leave space for the bottom bar
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
                          Text(
                            'Results',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
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
                            columnSpacing: 12, // Reduce column spacing
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
      ],
    );
  }
}
