import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AwesomeLoadingPopup extends StatelessWidget {
  const AwesomeLoadingPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SpinKitWave(
              color: Colors.blue, // Customize the color of the animation
              size: 50.0, // Customize the size of the animation
            ),
            SizedBox(height: 16),
            Text(
              'Loading...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void showAwesomeLoadingPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AwesomeLoadingPopup();
    },
  );
}