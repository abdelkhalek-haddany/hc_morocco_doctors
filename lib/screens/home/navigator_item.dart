import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/home/home.dart';
import 'package:hc_morocco_doctors/screens/pharmacy/pharmacy.dart';
import 'package:hc_morocco_doctors/screens/profile/doctor_profile_screen.dart';


import '../doctors/doctors.dart';


class NavigatorItem {
  final String label;
  final String iconPath;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.iconPath, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Home", "assets/icons/home.svg", 0, const Home()),
  NavigatorItem("Doctors", "assets/icons/doctors.svg", 1, const Doctors()),
  NavigatorItem("Pharmacy", "assets/icons/pharmacy.svg", 2,  DoctorProfile("kihniedughfefrf")),
  NavigatorItem("Search", "assets/icons/search.svg", 3, Pharmacy()),
  NavigatorItem("Favourite", "assets/icons/favourite_icon.svg", 4, Doctors())];