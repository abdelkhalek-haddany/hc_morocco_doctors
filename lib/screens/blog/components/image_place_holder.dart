import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/themes/style.dart';

class ImagePlaceHolder extends StatelessWidget {
  const ImagePlaceHolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: BoxDecoration(border: Border.all(width: 1, color: primaryColor),
      borderRadius: BorderRadius.circular(5)),

      child: const Icon(Icons.add_a_photo, size: 40.0, color: Color.fromRGBO(165, 117, 255, 1)),
    );
  }
}
