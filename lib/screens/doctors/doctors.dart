import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/doctors/doctors_widgets.dart';

class Doctors extends StatefulWidget {
  const Doctors({Key? key}) : super(key: key);

  @override
  State<Doctors> createState() => _DoctorsState();
}

class _DoctorsState extends State<Doctors> {
  @override
  Widget build(BuildContext context) {
    return DoctorsSection();
  }
}
