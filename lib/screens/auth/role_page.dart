import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/auth/signup_doctor_screen.dart';
import 'package:hc_morocco_doctors/screens/auth/signup_screen.dart';
import 'package:hc_morocco_doctors/themes/style.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  void _navigateToDoctorRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpDoctorScreen()),
    );
  }

  void _navigateToUserRegistration(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Stack(
        children: [
          const Positioned.fill(
            child: CustomBackground(),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => _navigateToDoctorRegistration(context),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/medical-team.png',
                          height: 100,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'I am a Doctor',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _navigateToUserRegistration(context),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    height: 200,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/patient.png',
                          height: 100,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'I am a User',
                          style: TextStyle(fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        painter: BackgroundPainter(),
      ),
    );
  }
}
class BackgroundPainter extends CustomPainter {
  final RandomShapeGenerator _shapeGenerator = RandomShapeGenerator();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bluePaint = Paint()..color = primaryColor;
    final Paint lightBluePaint = Paint()..color = Colors.lightBlueAccent;

    final double waveHeight = 100;

    final Path wavePath1 = Path()
      ..moveTo(0, size.height - waveHeight)
      ..quadraticBezierTo(size.width / 4, size.height - waveHeight + waveHeight / 2, size.width / 2, size.height - waveHeight)
      ..quadraticBezierTo(size.width * 3 / 4, size.height - waveHeight - waveHeight / 2, size.width, size.height - waveHeight)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(wavePath1, bluePaint);

    final Path wavePath2 = Path()
      ..moveTo(0, size.height - waveHeight * 2)
      ..quadraticBezierTo(size.width / 4, size.height - waveHeight * 2 + waveHeight / 2, size.width / 2, size.height - waveHeight * 2)
      ..quadraticBezierTo(size.width * 3 / 4, size.height - waveHeight * 2 - waveHeight / 2, size.width, size.height - waveHeight * 2)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(wavePath2, lightBluePaint);

    final List<CircleShape> circles = _shapeGenerator.generateCircles(size.width, size.height);
    for (final circle in circles) {
      final Paint circlePaint = Paint()
        ..color = lightBluePaint.color.withAlpha(100 + _shapeGenerator.random.nextInt(156)); // Lower opacity
      canvas.drawCircle(circle.center, circle.radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class RandomShapeGenerator {
  final Random random = Random();

  List<CircleShape> generateCircles(double width, double height) {
    final List<CircleShape> circles = [];

    for (int i = 0; i < 30; i++) {
      final double size = 10 + random.nextDouble() * 40; // Random size between 10 and 50
      final double x = random.nextDouble() * width;
      final double y = random.nextDouble() * height;

      circles.add(CircleShape(Offset(x, y), size));
    }

    return circles;
  }
}
class CircleShape {
  final Offset center;
  final double radius;

  CircleShape(this.center, this.radius);
}
