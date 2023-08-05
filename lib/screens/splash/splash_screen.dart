import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import 'package:hc_morocco_doctors/screens/home/DashboardScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    const delay = const Duration(seconds: 2);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(
      builder: (BuildContext context) {
        return DashboardScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
          splashScreenIcon(),
      ]
      ),
    );
  }
}

Widget splashScreenIcon() {
  String iconPath = "assets/icons/splash_icon.png";
  return Image.asset(iconPath);
}