import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    
    TabIconData(
      imagePath: 'assets/images/landing/home.png',
      selectedImagePath: 'assets/images/landing/home_.png',
      index: 0,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/landing/report.png',
      selectedImagePath: 'assets/images/landing/report_.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/images/landing/set.png',
      selectedImagePath: 'assets/images/landing/set_.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
     TabIconData(
      imagePath: 'assets/images/landing/qr.png',
      selectedImagePath: 'assets/images/landing/qr_.png',
      index: 3,
      isSelected: true,
      animationController: null,
    ),

     ];
}
