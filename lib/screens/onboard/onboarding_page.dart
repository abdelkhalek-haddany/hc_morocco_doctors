import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/home/DashboardScreen.dart';
import './model/OnboardingPageModel.dart';

class OnboardingPage extends StatefulWidget {
  final List<OnboardingPageModel> pages;

  const OnboardingPage({Key? key, required this.pages}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  // Store the currently visible page
  int _currentPage = 0;

  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Stack(
        children: [
          // Custom background with shapes
          AnimatedBackground(),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  // Pageview to render each page
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.pages.length,
                    onPageChanged: (idx) {
                      // Change current page when pageview changes
                      setState(() {
                        _currentPage = idx;
                      });
                    },
                    itemBuilder: (context, idx) {
                      final _item = widget.pages[idx];
                      return Column(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Image.asset(
                                _item.image,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    _item.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: _item.textColor,
                                        ),
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 280),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0, vertical: 8.0),
                                  child: Text(
                                    _item.description,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(
                                          color: _item.textColor,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Current page indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.pages
                      .map(
                        (item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == widget.pages.indexOf(item)
                              ? 20
                              : 4,
                          height: 4,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      )
                      .toList(),
                ),

                // Bottom buttons
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            margin: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Skip",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DashboardScreen(),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          if (_currentPage == widget.pages.length - 1) {
                            // This is the last page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                            );
                          } else {
                            _pageController.animateToPage(
                              _currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250),
                            );
                          }
                        },
                        child: _currentPage == widget.pages.length - 1
                            ? InkWell(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Finish",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardScreen(),
                                    ),
                                  );
                                },
                              )
                            : InkWell(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                                onTap: () {
                                  setState(() {
                                    _currentPage = _currentPage + 1;
                                  });
                                },
                              ),
                      ),
                    ],
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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _controller.addListener(() {
      setState(() {});
    });
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
          _buildShape()
        ],
      ),
    );
  }

  Widget _buildShape() {
    final random = 3;
    switch (random) {
      case 0:
        return CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.3),
          radius: _randomDouble(30, 50),
        );
      case 1:
        return Container(
          width: _randomDouble(40, 80),
          height: _randomDouble(20, 40),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      case 2:
        return Container(
          width: _randomDouble(25, 45),
          height: _randomDouble(25, 45),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: CustomPaint(
            painter: TrianglePainter(),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  double _randomDouble(double min, double max) =>
      min + Random().nextDouble() * (max - min);
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

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xa575ff)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
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
    return false;
  }
}
