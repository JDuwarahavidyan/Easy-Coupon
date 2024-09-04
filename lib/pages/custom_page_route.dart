import 'package:flutter/material.dart';

class CustomPageTransition extends PageRouteBuilder {
  final Widget page;
  final bool slideLeftToRight;

  CustomPageTransition({required this.page, required this.slideLeftToRight})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const curve = Curves.ease;

            final tween = Tween(
              begin: slideLeftToRight ? Offset(-1.0, 0.0) : Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
