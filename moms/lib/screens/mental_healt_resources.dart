// mental_health_screen.dart
import 'package:flutter/material.dart';
import 'package:healthy_moms/mental_assessment.dart/assesment.dart';
import 'package:healthy_moms/screens/pdf_viewer_screen.dart';
// import 'package:moms/mental_assessment.dart/assesment.dart';
// import 'package:moms/screens/pdf_viewer_screen.dart';
// Import the assessment screen

class MentalHealthScreen extends StatelessWidget {
  final List<Map<String, String>> resources = [
    {
      'title': 'Understanding Postpartum Depression',
      'description': 'Learn about signs, symptoms, and support options.',
      'pdf': 'assets/postpartum_guide.pdf',
    },
    {
      'title': 'Self-Care Tips',
      'description': 'Simple practices to improve your mental well-being.',
      'pdf': 'assets/Self_Care_After_Childbirth.pdf',
    },
    {
      'title': 'Connect with Counselors',
      'description': 'Find professional help near you.',
    },
    {
      'title':
          'Mental Health Assessment', // Add this new entry for the assessment tool
      'description': 'Take an assessment to evaluate your mental health.',
      'type': 'assessment', // This is a custom type to differentiate the action
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 34,
            )),
        title: Text(
          'Mental Health Resources',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.health_and_safety),
            title: Text(resources[index]['title']!),
            subtitle: Text(resources[index]['description']!),
            onTap: () {
              if (resources[index].containsKey('pdf')) {
                // Open the PDF if the resource has a PDF file associated
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerScreen(
                      filePath: resources[index]['pdf']!,
                    ),
                  ),
                );
              } else if (resources[index]['type'] == 'assessment') {
                // Navigate to the mental health assessment screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MentalHealthAssessmentScreen(),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
