import 'dart:ui'; 
import 'package:easy_coupon/bloc/blocs.dart';
import 'package:easy_coupon/pages/student_pages/student_home.dart';
import 'package:easy_coupon/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'package:intl/intl.dart';
import 'package:easy_coupon/models/qr/qr_model.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Student_report extends StatefulWidget {
  const Student_report({Key? key}) : super(key: key);

  @override
  _Student_reportState createState() => _Student_reportState();
}

class _Student_reportState extends State<Student_report> with TickerProviderStateMixin {
  AnimationController? animationController;
  Widget tabBody = Container(
    color: Colors.white,
  );
  List<DateTime?> _dates = [DateTime.now()];
  bool _showTable = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fetchUserQrCodes();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _fetchUserQrCodes({DateTime? startDate, DateTime? endDate}) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      context.read<QrCodeBloc>().add(LoadQrCodesByUid(currentUser.uid, startDate: startDate, endDate: endDate, reportType: 'student_report'));
    }
  }

  void _fetchData() {
    setState(() {
      _showTable = true;
    });
    if (_dates.length >= 2 && _dates[0] != null && _dates[1] != null) {
      _fetchUserQrCodes(startDate: _dates[0], endDate: _dates[1]);
    }
  }

  void _closeTable() {
    setState(() {
      _showTable = false;
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
                color: Color(0xFFDBE7C9).withOpacity(0.1),
               
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
  Text(
    "Report Page",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      color: Color(0xFF294B29).withOpacity(1), // 50% transparency
      fontSize: 25,
    ),
  ),
],

                ),
              ),
            ),
            Positioned(
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
                      selectedDayTextStyle: const TextStyle(color: Colors.white),
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
            ),

            if (_showTable) ...[
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(color: Colors.black.withOpacity(0.5)),
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
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10.0)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Results', style: Theme.of(context).textTheme.titleLarge),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: _closeTable,
                          ),
                        ],
                      ),
                      Expanded(
                        child: BlocBuilder<QrCodeBloc, QrCodeState>(
                          builder: (context, state) {
                            print('Current QrCodeBloc state: $state');
                            if (state is QrCodeLoading) {
                              return Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                  color: const Color(0xFF50623A),
                                  size: 50,
                                ),
                              );
                            } else if (state is QrCodeLoaded) {
                              final startDate = _dates.isNotEmpty && _dates.length > 0 ? _dates[0] : null;
                              final endDate = _dates.isNotEmpty && _dates.length > 1 ? _dates[1] : null;

                              final filteredQrcodes = state.qrcodes.where((item) {
                                final itemDate = item.scannedAt;

                                if (startDate != null && endDate != null) {
                                  return itemDate.isAfter(startDate) && itemDate.isBefore(endDate.add(const Duration(days: 1)));
                                } else if (startDate != null) {
                                  return itemDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
                                      itemDate.isBefore(startDate.add(const Duration(days: 1)));
                                } else if (endDate != null) {
                                  return itemDate.isBefore(endDate.add(const Duration(days: 1)));
                                } else {
                                  return true;
                                }
                              }).toList()
                                ..sort((a, b) => b.scannedAt.compareTo(a.scannedAt));

                              print('Filtered QR codes: ${filteredQrcodes.length}');
                              if (filteredQrcodes.isEmpty) {
                                return Center(child: Text('No data available for the selected date range'));
                              }

                              return Column(
                                children: [
                                  // Fixed Header
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Date',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                '& Time',
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Text(
                                              'Canteen',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text(
                                              'Coupon\nUsed',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columns: const [
                                            DataColumn(label: Center(child: Text(''))), // Empty as we have headers above
                                            DataColumn(label: Center(child: Text(''))),
                                            DataColumn(label: Center(child: Text(''))),
                                          ],
                                          rows: filteredQrcodes.map((QRModel item) {
                                            return DataRow(cells: [
                                              DataCell(
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(DateFormat('dd/MM/yyyy').format(item.scannedAt)),
                                                    Text(
                                                      DateFormat('hh:mm a').format(item.scannedAt),
                                                      style: TextStyle(color: Colors.grey, fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              DataCell(Text(item.canteenName.toLowerCase())),
                                              DataCell(Text(item.count.toString())),
                                            ]);
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      'Total Coupons Used: ${filteredQrcodes.fold<int>(0, (sum, item) => sum + item.count)}',
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ),
                                ],
                              );
                            } else if (state is QrCodeFailure) {
                              return Center(child: Text('Error: ${state.message}'));
                            } else {
                              return Center(child: Text('No data'));
                            }
                          },
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


  Widget bottomBar() {
    return Column(
      
    );
  }
}
