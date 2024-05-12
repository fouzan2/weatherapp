import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weatherapp/widgets/Onboarding_card.dart';
import 'package:weatherapp/screens/searchPage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _onBoardingPage = [];

  @override
  void initState() {
    super.initState();
    _onBoardingPage = [
      OnboardingCard(
        image: "assets/images/onboarding1.gif",
        title: "Welcome to Climy!",
        description:
        "Introducing the Weather App which tells about the current temparature of a given City.",
        buttonText: "Next",
        onPressed: () {
          _pageController.animateToPage(
            1,
            duration: Durations.long1,
            curve: Curves.linear,
          );
        },
      ),
      OnboardingCard(
        image: "assets/images/onboarding2.gif",
        title: "API Integration",
        description:
        "Integrating the Open Weather Api to get the Weather Forcast.",
        buttonText: "Next",
        onPressed: () {
          _pageController.animateToPage(
            2,
            duration: Durations.long1,
            curve: Curves.linear,
          );
        },
      ),
      OnboardingCard(
        image: "assets/images/onboarding3.gif",
        title: "Add Your Location",
        description:
        "Add the location of a city, you want to get the weather forcast.",
        buttonText: "Search",
        onPressed: () {
          navigateToEnterCityScreen();
        },
      ),
    ];
  }

  void navigateToEnterCityScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _onBoardingPage,
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onBoardingPage.length,
              onDotClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: Durations.long1,
                  curve: Curves.linear,
                );
              },
              effect: const ExpandingDotsEffect( // You can use different effects here like JumpingDotEffect, ScaleEffect, etc.
                dotColor: Colors.teal,
                activeDotColor: Colors.black, // Change the color of the dots here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
