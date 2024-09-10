import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:easy_coupon/widgets/widgets.dart';

class SplashView extends StatefulWidget {
  final AnimationController animationController;

  const SplashView({super.key, required this.animationController});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    final introductionanimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return SlideTransition(
      position: introductionanimation,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: SizedBox(
              height: screenHeight, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.3, 
                    child: Lottie.asset(
                      'assets/images/landing/qr_mob.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    "Easy Coupon",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.15, 
                    ),
                    child: const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      widget.animationController.animateTo(0.2);
                    },
                    child: Container(
                      height: 58,
                      width: screenWidth * 0.6, 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(38.0),
                        color: AppColors.buttonColor,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Let's begin",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
