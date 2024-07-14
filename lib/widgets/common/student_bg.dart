import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../widgets/widgets.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report Page',
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color(0xFFFCD170),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: UserProfileAvatar(),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define a base width for iPhone 12 Pro

          return Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xFFF9E6BD),
            child: Center(
              child: Container(
                width: constraints.maxWidth * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCD170),
                  borderRadius: BorderRadius.circular(30),
                ),
                // Placeholder for additional widgets/content
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
