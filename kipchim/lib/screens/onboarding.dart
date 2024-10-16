import 'package:flutter/material.dart';
import 'package:kipchim/pages/home.dart';
import 'package:kipchim/screens/otp.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "title": "Track your harvest & earnings",
      "description": "Monitor weight, manage loans, and stay informed.",
    },
    {
      "title": "Manage your finances",
      "description":
          "Transfer funds, access mobile money, top up airtime & save for the future.",
    },
    {
      "title": "Get support & grow faster",
      "description":
          "Apply for loans directly, submit requests, and view helpful information.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // PageView for onboarding screens
            Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return OnboardingPage(
                        title: onboardingData[index]["title"]!,
                        description: onboardingData[index]["description"]!,
                        isLastPage: _currentPage == onboardingData.length - 1,
                        onNextPressed: () {
                          if (_currentPage == onboardingData.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RequestOTPScreen()),
                            );
                          } else {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            // Skip button at the top-right of the screen, hidden on the last screen
            if (_currentPage != onboardingData.length - 1)
              Positioned(
                top: 16,
                right: 16,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final bool isLastPage;
  final VoidCallback onNextPressed;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.isLastPage,
    required this.onNextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 140.0,
          left: 40.0,
          right: 40.0), // Moved content down by 100 pixels
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          // Next Button Below the Text
          SizedBox(
            width: 300, // Adjust button width as needed
            child: ElevatedButton(
              onPressed: onNextPressed,
              child: Text(
                isLastPage ? 'Sign me in!' : 'Next',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: isLastPage ? Colors.amberAccent : Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
