import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/pages/student_pages/qr_scanning.dart';
import 'package:easy_coupon/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:lottie/lottie.dart';

import 'package:easy_coupon/widgets/common/bottom_navigation.dart';

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
class StudentHome extends StatefulWidget {
  const StudentHome({super.key, AnimationController? animationController});

  @override
  // ignore: library_private_types_in_public_api
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> with TickerProviderStateMixin {
  AnimationController? animationController;
  // List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(
    color: Colors.white,
  );
  int _selectedCoupons = 1; // Variable to track the selected number of coupons

  @override
  void initState() {
    super.initState();

    // for (var tab in tabIconsList) {
    //   tab.isSelected = false;
    // }
    // tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    // Initial tab body for the report page
    // tabBody = MyDiaryScreen(animationController: animationController);

    // Initialize UserBloc and fetch user data
    context.read<UserBloc>().add(UserReadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        body: Stack(
          children: [
            Center(
              child: FutureBuilder<bool>(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return Center(child: LoadingAnimationWidget.fourRotatingDots(
                              color: Color(0xFF50623A),
                              size: 50,
                            ),);
                          } else if (state is UserLoaded) {
                            final user = state.users.firstWhere(
                              (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
                            );
                            return LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        'Hi, Welcome Back!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF294B29),
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20),
                                      child: Container(
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF789461).withOpacity(0.1),
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
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        'Remaining Coupons as per ${DateTime.now().toString().substring(0, 10)}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: DonutChart(
                                        animation: animationController!,
                                        couponCount: user.studentCount, // Pass the user's coupon count
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Container(
                                        width: constraints.maxWidth - 50 ,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF789461),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Select the number of coupons',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  iconSize: 30,
                                                  icon: const Icon(Icons.remove, color: Colors.white),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (_selectedCoupons > 1) {
                                                        _selectedCoupons--;
                                                      }
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 15),
                                                Text(
                                                  '$_selectedCoupons',
                                                  style: const TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                IconButton(
                                                  iconSize: 30,
                                                  icon: const Icon(Icons.add, color: Colors.white),
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
                                    const SizedBox(height: 20),
                                    Center(
                                      child: Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: const Color(0xFF789461),
                                            width: 2.0,
                                          ),
                                        ),
                                        child: CupertinoButton(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                          color: Colors.transparent,
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(CupertinoIcons.qrcode, color: Color(0xFF789461)),
                                              SizedBox(width: 10),
                                              Text(
                                                'SCAN ME',
                                                style: TextStyle(
                                                  color: Color(0xFF789461),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            if (user.studentCount - _selectedCoupons >= 0) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => QrPage(
                                                    val: _selectedCoupons,
                                                    studentUserId: user.id,
                                                    studentUserName: user.userName,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return CupertinoAlertDialog(
                                                    title: const Text('No More Coupons'),
                                                    content: const Text(
                                                        'Your coupons are over. Please contact the admin to get more coupons.'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text('OK'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: 250,
                                        height: constraints.maxHeight * 0.25, // Adjust the height relative to screen height
                                        child: Center(
                                          child: Lottie.asset(
                                            'assets/images/landing/cook.json',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          return const Center(child: Text('Failed to load user data'));
                        },
                      ),
                    );
                  }
                },
              ),
            ),
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


class DonutChart extends StatelessWidget {
  final AnimationController animation;
  final int couponCount;

  const DonutChart({required this.animation, required this.couponCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: AspectRatio(
        aspectRatio: 2, // Adjusted aspect ratio for a larger circular chart
        child: Center(
          child: Stack(
            alignment: Alignment.center, // Center the text and circular indicator
            children: <Widget>[
              SizedBox(
                width: 180, // Increase the size of the donut chart
                height: 180,
                child: CircularProgressIndicator(
                  value: couponCount / 30,
                  strokeWidth: 20.0, // Increase stroke width for a thicker chart
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF789461)),
                  backgroundColor: const Color(0xFF789461).withOpacity(0.2),
                ),
              ),
              Center(
                child: Text(
                  '$couponCount',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF789461),
                    fontSize: 90, // Increase font size for the coupon count
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

