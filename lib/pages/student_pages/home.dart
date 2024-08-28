import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_diary/my_diary_screen.dart';
import 'package:easy_coupon/widgets/common/bottom_navigation.dart';

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

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();

    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return tabBody;
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0), // Adjust this value to place above bottom bar
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                        context,
                        '/qr',
                        );
                },
                icon: Icon(CupertinoIcons.qrcode_viewfinder, color: Color(0xFF294B29)),
                label: Text(
                  "Scan the QR",
                  style: TextStyle(
                    color: Color(0xFF294B29), // Green color for the text
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
              // Set the tab body to your Report screen when the Report tab is clicked.
              // tabBody = ReportScreen(); // Replace with your Report screen
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
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}




