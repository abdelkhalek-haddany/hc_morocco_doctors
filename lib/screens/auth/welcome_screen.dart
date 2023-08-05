import 'package:flutter/material.dart';
import '../../constants.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          // Updated Custom background with shapes and animations
          AnimatedBackground(),
          // Content of the welcome screen with animations
          Positioned(
            top: 120,
            left: 30,
            child: Wrap(
              direction: Axis.vertical,
              children: [
                // Animated "Hello" text
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                // Animated description text
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Container(
                      width: 250,
                      child: Opacity(
                        opacity: value,
                        child: const Text(
                          'Explore a world of possibilities on our health car application',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            left: 30,
            right: 30,
            child: Column(
              children: [
                // Animated Sign In button
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeInOut,
                  )),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue[900],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Animated Sign Up button
                SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: ModalRoute.of(context)!.animation!,
                    curve: Curves.easeInOut,
                  )),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.transparent,
                      side: BorderSide(color: Colors.white, width: 2),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    ),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
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

class AnimatedBackground extends StatefulWidget {
  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<ShapeData> shapes = [
    ShapeData(shapeType: ShapeType.circle, size: 60, x: 0.3, y: 0.3),
    ShapeData(shapeType: ShapeType.circle, size: 45, x: 0.7, y: 0.6),
    ShapeData(shapeType: ShapeType.circle, size: 90, x: 0.5, y: 0.9),
    ShapeData(shapeType: ShapeType.rectangle, width: 80, height: 40, x: 0.8, y: 0.2),
    ShapeData(shapeType: ShapeType.triangle, size: 45, x: 0.1, y: 0.05),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(_controller.value),
      size: Size(double.infinity, double.infinity),
      child: Stack(
        children: [
          for (var i = 0; i < shapes.length; i++)
            AnimatedPositioned(
              top: shapes[i].y * MediaQuery.of(context).size.height,
              left: shapes[i].x * MediaQuery.of(context).size.width,
              duration: Duration(seconds: 5),
              curve: Curves.easeInOut,
              child: _buildShape(shapes[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildShape(ShapeData shapeData) {
    if (shapeData.shapeType == ShapeType.circle) {
      return CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.3),
        radius: shapeData.size,
      );
    } else if (shapeData.shapeType == ShapeType.rectangle) {
      return Container(
        width: shapeData.width,
        height: shapeData.height,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    } else if (shapeData.shapeType == ShapeType.triangle) {
      return Container(
        width: shapeData.size,
        height: shapeData.size,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: CustomPaint(
          painter: TrianglePainter(),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

enum ShapeType { circle, rectangle, triangle }

class ShapeData {
  final ShapeType shapeType;
  final double size;
  final double width;
  final double height;
  final double x;
  final double y;

  ShapeData({
    required this.shapeType,
    this.size = 20,
    this.width = 20,
    this.height = 20,
    required this.x,
    required this.y,
  });
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xa575ff)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(1, size.height * 0.9)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.75,
        size.width * 0.4,
        size.height * 0.6,
        size.width * 0.6,
        size.height * 0.7,
      )
      ..cubicTo(
        size.width * 0.7,
        size.height * 0.75,
        size.width * 0.85,
        size.height * 0.8,
        size.width,
        size.height * 0.75,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
        ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
