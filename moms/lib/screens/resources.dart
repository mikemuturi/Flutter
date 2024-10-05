import 'package:flutter/material.dart';
import 'package:healthy_moms/screens/homepage.dart';
import 'package:healthy_moms/screens/pdf_viewer_screen.dart';
// Import the PDF viewer screen

class ResourcesScreen extends StatelessWidget {
  final List<Map<String, String>> resources = [
    {
      'title': 'Nutrition During Pregnancy',
      'category': 'Nutrition',
    },
    {
      'title': 'Exercise Safely',
      'category': 'Fitness',
    },
    {
      'title': 'Preparing for Labor',
      'category': 'Labor',
    },
    {
      'title': 'Exercise Tips', // New article
      'category': 'Fitness',
      'type': 'pdf', // Indicate it's an article
      'content': 'Here are some tips for exercising safely during pregnancy...',
      'filePath': 'assets/Prenatal-Yoga-Sequence.pdf',
    },
    {
      'title': 'Pregnancy Guide PDF', // New PDF resource
      'category': 'PDF',
      'type': 'pdf', // Indicate it's a PDF
      'filePath': 'assets/pregnancy_guide.pdf', // Ensure this path is correct
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.purple,
              size: 34,
            )),
        title: const Text(
          'Resources',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.book),
            title: Text(resources[index]['title']!),
            subtitle: Text(resources[index]['category']!),
            onTap: () {
              if (resources[index]['type'] == 'article') {
                // Navigate to article details
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(resources[index]['title']!),
                      content: Text(resources[index]['content']!),
                      actions: [
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (resources[index]['type'] == 'pdf') {
                // Navigate to PDF viewer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PDFViewerScreen(
                      filePath: resources[index]['filePath']!,
                    ),
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
