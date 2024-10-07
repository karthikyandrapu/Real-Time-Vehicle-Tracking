import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int lastPage = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50.0), // Add a SizedBox for top spacing
          Expanded(
            child: IntroductionScreen(
              globalBackgroundColor: Colors.white,
              scrollPhysics: BouncingScrollPhysics(),
              pages: [
                PageViewModel(
                  titleWidget: Text(
                    "Discover HRTC's Smart Transportation",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  body:
                      "Explore the future of public transportation in Himachal Pradesh with our smart transportation system. Get real-time information about bus availability and arrival times. Travel with ease and efficiency.",
                  image: Lottie.asset(
                    'lib/images/animation_screen1.json',
                    height: 400,
                    width: 400,
                  ),
                ),
                PageViewModel(
                  titleWidget: Text(
                    "Real-Time Tracking",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  body:
                      "Our system utilizes advanced GPS technology and traffic management data to help you track your desired bus in real-time. Know exactly where your bus is and when it will arrive at your stop.",
                  image: Lottie.asset(
                    "lib/images/animation_screen2.json",
                    height: 400,
                    width: 400,
                  ),
                ),
                PageViewModel(
                  titleWidget: Text(
                    "Eco-Friendly Travel",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  body:
                      "We care about the environment. Our buses are eco-friendly and comply with emission standards like Bharat Stage IV. Many of our buses run on clean fuels like CNG or electricity for a sustainable future.",
                  image: Lottie.asset(
                    "lib/images/animation_screen3.json",
                    height: 400,
                    width: 400,
                  ),
                ),
              ],
              onDone: () {
                Navigator.pushNamed(context, "auth");
              },
              onSkip: () {
                Navigator.pushNamed(context, "auth");
              },
              showSkipButton: true,
              skip: Text(
                "Skip",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6C63FF),
                ),
              ),
              next: Icon(
                Icons.arrow_forward,
                color: Color(0xFF6C63FF),
              ),
              done: Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6C63FF),
                ),
              ),
              dotsDecorator: DotsDecorator(
                size: Size.square(10.0),
                activeSize: Size(20.0, 10.0),
                color: Colors.black26,
                activeColor: Color(0xFF6C63FF),
                spacing: EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
