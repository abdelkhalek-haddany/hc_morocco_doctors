import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/home/home_widgets.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
      children:const [
        DoctorsBanner(),
        DepartmentSection(),
        PostsSection(),
      ],
      )
    );
  }
}