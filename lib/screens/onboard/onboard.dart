import 'package:flutter/material.dart';
import 'package:hc_morocco_doctors/screens/onboard/model/OnboardingPageModel.dart';
import 'package:hc_morocco_doctors/screens/onboard/onboarding_page.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  @override
  Widget build(BuildContext context) {
    return OnboardingPage(
      pages: [
        OnboardingPageModel(
          title: 'Fast, Fluid and Secure',
          description: 'Enjoy the best of the world in the palm of your hands.',
          image: 'assets/images/image0.png',
          bgColor: Colors.indigo,
        ),
        OnboardingPageModel(
          title: 'Connect with your friends.',
          description: 'Connect with your friends anytime anywhere.',
          image: 'assets/images/image1.png',
          bgColor: const Color(0xff1eb090),
        ),
        OnboardingPageModel(
          title: 'Bookmark your favourites',
          description: 'Bookmark your favourite quotes to read at a leisure time.',
          image: 'assets/images/image2.png',
          bgColor: const Color(0xfffeae4f),
        ),
        OnboardingPageModel(
          title: 'Follow creators',
          description: 'Follow your favourite creators to stay in the loop.',
          image: 'assets/images/image3.png',
          bgColor: Colors.purple,
        ),
      ],
    );
  }
}
