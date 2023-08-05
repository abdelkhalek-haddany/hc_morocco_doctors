import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/components/app_bar.dart';
import 'package:hc_morocco_doctors/components/drawer/custom_drawer.dart';
import 'package:hc_morocco_doctors/themes/style.dart';
import 'package:hc_morocco_doctors/screens/home/navigator_item.dart';
import 'package:flutter_svg/svg.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      drawer: const CustomDrawer(),
      appBar: buildAppBar(context),
      body: navigatorItems[currentIndex].screen,
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black38.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 37,
                offset: Offset(0, -12)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primaryColor,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            items: navigatorItems.map((e) {
              return getNavigationBarItem(
                  label: e.label, index: e.index, iconPath: e.iconPath);
            }).toList(),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem getNavigationBarItem(
      {required String label, required String iconPath, required int index}) {
     if(index == currentIndex) {
       return BottomNavigationBarItem(
         label: label,
         icon: SvgPicture.asset(
             iconPath,
             color: primaryColor,
             height: 20,
             width: 20,
         ),
       );
     }
     return BottomNavigationBarItem(
       label: label,
       icon: SvgPicture.asset(
         iconPath,
         height: 20,
         width: 20,
       ),
     );
  }
}