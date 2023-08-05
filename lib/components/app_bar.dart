import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/customer/questions/create-question.dart';

import '../screens/admin/departments/create-department.dart';

AppBar buildAppBar(BuildContext context){
  final icon = Icons.add;
  return AppBar(
    iconTheme: const IconThemeData(color: Colors.black87),
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: [
      IconButton(icon: Icon(icon),
          onPressed: ()=>{
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CreateQuestionScreen())),
          }),
    ],
  );
}