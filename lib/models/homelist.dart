import 'dart:io';
import 'package:flutter/widgets.dart';


class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

 static List<HomeList> homeList = [
   HomeList(
     imagePath: 'assets/introduction_animation/introduction_animation.png',
     navigateScreen: Container(child: Text('1')),
  ),
   HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: Container(child: Text('2'),),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/fitness_app.png',
      navigateScreen: Container(child: Text('3'),),
    ),
    HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: Container(child: Text('4'),),
    ),
  ];
}
