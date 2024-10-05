import 'package:flutter/material.dart';
import 'package:healthy_moms/screens/login.dart';
// import 'package:moms/screens/login.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _controller = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/Tips.png',
      'title': 'Track Your Pregnancy',
      'description': 'Get personalized updates and tips each week.'
    },
    {
      'image': 'assets/images/nutrionist.jpeg',
      'title': 'Nutrition',
      'description': 'Access well-curated specialized meal plans.'
    },
    {
      'image': 'assets/images/mentalhealth.jpeg',
      'title': 'Mental Health Resources',
      'description': 'Find support and resources for your well-being.'
    },
  ];

  void _skipToRegistration(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return OnboardingPage(
                  image: onboardingData[index]['image']!,
                  title: onboardingData[index]['title']!,
                  description: onboardingData[index]['description']!,
                  isLastPage: index == onboardingData.length - 1,
                  onNext: () {
                    if (index == onboardingData.length - 1) {
                      _skipToRegistration(context);
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                );
              },
            ),
            Positioned(
              top: 10,
              right: 10,
              child: TextButton(
                onPressed: () => _skipToRegistration(context),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.purple, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image, title, description;
  final bool isLastPage;
  final VoidCallback onNext;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
    required this.isLastPage,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 500, // Set the height to 300
            width: 300, // Set the width to 200
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text(isLastPage ? 'Get Started' : 'Next'),
            onPressed: onNext,
          ),
        ],
      ),
    );
  }
}
