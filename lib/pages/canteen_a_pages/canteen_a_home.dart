import 'package:easy_coupon/models/user/user_model.dart';
//import 'package:easy_coupon/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_coupon/bloc/user/user_bloc.dart';
import 'package:easy_coupon/routes/route_names.dart';
import 'package:easy_coupon/widgets/common/background.dart';
import 'package:easy_coupon/widgets/common/segment_c.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';

class CanteenAHome extends StatefulWidget {
  const CanteenAHome({super.key});

  @override
  _CanteenAHomeState createState() => _CanteenAHomeState();
}

class _CanteenAHomeState extends State<CanteenAHome> with TickerProviderStateMixin, RouteAware {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    context.read<UserBloc>().add(UserReadEvent());
  }

  @override
  /*void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    animationController?.dispose();
    super.dispose();
  }*/

  @override
  void didPopNext() {
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
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserLoaded) {
                  final UserModel user = state.users.firstWhere(
                    (user) => user.id == FirebaseAuth.instance.currentUser?.uid,
                  );
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Welcome Back, ${user.userName}!',
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
                                              'Click on the button to initiate the process of generating the QR code.',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Transform.scale(
                                            scale: 1.7,
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Lottie.asset(
                                                'assets/images/landing/qr_h.json',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Donut_c_Chart(
                                        animation: animationController!,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Center(),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(15.0),
                                          border: Border.all(
                                            color: Color(0xFF789461),
                                            width: 2.0,
                                          ),
                                        ),
                                        child: CupertinoButton(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                                          color: Colors.transparent,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(CupertinoIcons.qrcode, color: Color(0xFF789461)),
                                              SizedBox(width: 10),
                                              Text(
                                                'GENERATE QR',
                                                style: TextStyle(
                                                  color: Color(0xFF789461),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacementNamed(context, RouteNames.qr_g, arguments: user);
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 250,
                                      height: 250,
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
                return const Center(child: Text('Failed to load user data'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
