import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:expandable_datatable/expandable_datatable.dart';

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

class Student_report extends StatefulWidget {
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

  // Dummy data for the table
  List<Map<String, dynamic>> dummyData = [
    {"Date": "2024-08-01", "Number of Coupons": 120},
    {"Date": "2024-08-02", "Number of Coupons": 90},
    {"Date": "2024-08-03", "Number of Coupons": 110},
  ];

  late List<ExpandableColumn<dynamic>> headers;
  late List<ExpandableRow> rows;

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
    tabBody = MyDiaryScreen(animationController: animationController);

    // Initialize headers for the table
    headers = [
      ExpandableColumn<String>(columnTitle: "Date", columnFlex: 2),
      ExpandableColumn<int>(columnTitle: "Number of Coupons", columnFlex: 2),
    ];

    // Initialize rows for the table with dummy data
    rows = dummyData.map<ExpandableRow>((data) {
      return ExpandableRow(cells: [
        ExpandableCell<String>(columnTitle: "Date", value: data["Date"]),
        ExpandableCell<int>(
            columnTitle: "Number of Coupons", value: data["Number of Coupons"]),
      ]);
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
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Positioned(
                    top: 100,
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        CalendarDatePicker2(
                          config: CalendarDatePicker2Config(
                            calendarType: CalendarDatePicker2Type.range,
                          ),
                          value: _dates,
                          onValueChanged: (dates) {
                            setState(() {
                              _dates = dates;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _fetchData,
                          child: Text("Fetch"),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            if (_showTable) ...[
              // Blurred background
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              // Table popup
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                bottom: 50,
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
                        child: ExpandableTheme(
                          data: ExpandableThemeData(
                            context,
                            contentPadding: const EdgeInsets.all(20),
                            expandedBorderColor: Colors.transparent,
                            paginationSize: 48,
                            headerHeight: 56,
                            headerColor: Colors.amber[400],
                            headerBorder: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            ),
                            evenRowColor: const Color(0xFFFFFFFF),
                            oddRowColor: Colors.amber[200],
                            rowBorder: const BorderSide(
                              color: Colors.black,
                              width: 0.3,
                            ),
                            rowColor: Colors.green,
                            headerTextMaxLines: 4,
                            headerSortIconColor: const Color(0xFF6c59cf),
                            paginationSelectedFillColor:
                                const Color(0xFF6c59cf),
                            paginationSelectedTextColor: Colors.white,
                          ),
                          child: ExpandableDataTable(
                            headers: headers,
                            rows: rows,
                            multipleExpansion: false,
                            isEditable: false,
                            visibleColumnCount: 2,
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
                      MyDiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                // Set the tab body to your Report screen when the Report tab is clicked.
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
        ),
      ],
    );
  }
}
