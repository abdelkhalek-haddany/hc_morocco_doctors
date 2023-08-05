import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/themes/style.dart';

class AppButton extends StatelessWidget {
  final String label;
  final double roundness;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final Function onPressed;

  const AppButton({
    required this.label,
    this.roundness = 18,
    this.fontWeight = FontWeight.bold,
    this.padding = const EdgeInsets.symmetric(vertical: 24),
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: InkWell(
        child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: primaryColor,
        ),
        padding: padding,
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Center(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: fontWeight,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
        ),
        onTap: () {
          if (onPressed != null) onPressed();
        },
      ),
    );
  }
}