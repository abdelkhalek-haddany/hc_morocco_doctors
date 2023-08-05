import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/themes/style.dart';

import 'Customshape.dart';

class BezierContainer extends StatelessWidget {
  const BezierContainer({Key ?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: 0,
        child: ClipPath(
        clipper: Customshape(),
        child: Container(
          height: MediaQuery.of(context).size.height *.25,
          width: MediaQuery.of(context).size.width,
          color: primaryColor,
        ),
      ),
      )
    );
  }
}