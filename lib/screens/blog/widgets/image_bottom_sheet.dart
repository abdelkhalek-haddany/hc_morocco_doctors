import 'package:flutter/material.dart';

class ImageBottomSheet extends StatelessWidget {
  final String title;
  final VoidCallback cameraPressed;
  final VoidCallback galleryPressed;
  const ImageBottomSheet({
    Key? key,
    required this.title,
    required this.cameraPressed,
    required this.galleryPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.camera,
                color: Color.fromRGBO(165, 117, 255, 1),
              ),
              onPressed: cameraPressed,
              label: const Text(
                'Camera',
                style: TextStyle(
                  color: Color.fromRGBO(165, 117, 255, 1),
                ),
              ),
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.image,
                color: Color.fromRGBO(165, 117, 255, 1),
              ),
              onPressed: galleryPressed,
              label: const Text(
                'Gallery',
                style: TextStyle(
                  color: Color.fromRGBO(165, 117, 255, 1),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
