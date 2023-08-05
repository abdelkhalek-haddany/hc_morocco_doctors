import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hc_morocco_doctors/themes/style.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final Icon icon;

  const ProfileWidget(
      {Key? key, required this.imagePath, required this.onClicked,required this.icon, required bool isEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [buildImage(),
        Positioned(
          bottom: 0,
            right: 4,
            child:
            buildEditIcon(primaryColor)
         ),
            ]),
    );
  }

  buildImage() {
    final image = imagePath.contains('https://')
    ?NetworkImage(imagePath)
    :FileImage(File(imagePath));

    return ClipOval(
      child: Material(
          color: Colors.transparent,
          child: Ink.image(
              image: image as ImageProvider,
              fit: BoxFit.cover,
              width: 128,
              height: 128,
              child: InkWell(
                onTap: onClicked,
              ))),
    );
  }

  buildEditIcon(Color color) {
    return ClipOval(
        child: Material(
            color: Colors.white,
            child: Padding(
                padding: EdgeInsets.all(3),
                child: ClipOval(
                    child: Material(
                        color: color,
                        child: IconButton(
                          icon: icon,
                          color: Colors.white,
                          onPressed: () { this.onClicked();},
                        ))))));
  }
}
