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

class CanteenAReport extends StatefulWidget {
  const CanteenAReport({super.key});

  @override
  _CanteenAReportState createState() => _CanteenAReportState();
}

class _CanteenAReportState extends State<CanteenAReport>
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
            "Student": "eg203919",
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
          "Student",
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
        DataCell(Center(child: Text(data["Student"], style: _cellStyle))),
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
                      "Canteen Report Page",
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
          ],
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}
