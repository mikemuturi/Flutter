// pregnancy_tracker_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PregnancyTrackerScreen extends StatelessWidget {
  final int currentWeek;

  PregnancyTrackerScreen({required this.currentWeek});

  @override
  Widget build(BuildContext context) {
    // Sample data for the week
    String developmentInfo =
        'Your baby is growing rapidly. This week, the facial features are becoming more defined.';
    String tips = 'Remember to stay hydrated and maintain a balanced diet.';

    // Determine the current trimester
    int trimester = ((currentWeek - 1) ~/ 13) + 1;

    // Sample signs and symptoms
    List<String> signsAndSymptoms = [
      'Increased fatigue',
      'Nausea and vomiting',
      'Frequent urination',
      'Breast tenderness',
      'Mood swings',
    ];

    // Sample recommendations
    List<String> recommendations = [
      'Stay hydrated with plenty of water.',
      'Maintain a healthy and balanced diet rich in fruits and vegetables.',
      'Consult with your doctor if you experience severe symptoms.',
      'Consider joining a prenatal exercise class.',
      'Practice relaxation techniques like yoga or meditation.',
    ];

    // Sample clinics attended and upcoming events
    List<String> clinicsAttended = [
      'First Trimester Checkup - January 15',
      'Blood Test - February 20',
    ];

    List<String> upcomingEvents = [
      'Prenatal Yoga Class - March 5',
      'Ultrasound Appointment - March 15',
    ];

    // Get the current date
    DateTime now = DateTime.now();
    String currentDate = DateFormat('EEEE, MMMM d, yyyy').format(now);

    // Get the current month and year
    int currentMonth = now.month;
    int currentYear = now.year;

    // Calculate the first day of the month and the number of days in the month
    DateTime firstDayOfMonth = DateTime(currentYear, currentMonth, 1);
    int daysInMonth = DateTime(currentYear, currentMonth + 1, 0).day;

    // Generate the calendar grid
    List<Widget> calendarCells = [];
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(currentYear, currentMonth, i);
      bool isToday = date.day == now.day &&
          date.month == now.month &&
          date.year == now.year;
      calendarCells.add(
        Container(
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isToday ? Colors.purpleAccent : Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            '$i',
            style: TextStyle(
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              color: isToday ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

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
          ),
        ),
        title: Text(
          'Pregnancy Tracker',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Date: $currentDate',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              'Trimester $trimester, Week $currentWeek of Your Pregnancy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Calendar Section
            Text(
              'Calendar',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: calendarCells,
            ),
            SizedBox(height: 20),

            Text(
              developmentInfo,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Tips for This Week',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              tips,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Likely Signs and Symptoms',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...signsAndSymptoms.map((symptom) => Text(
                  '• $symptom',
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: 20),
            Text(
              'Recommendations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...recommendations.map((recommendation) => Text(
                  '• $recommendation',
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: 20),

            // Clinics Attended Section
            Text(
              'Clinics Attended',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...clinicsAttended.map((clinic) => Text(
                  '• $clinic',
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: 20),

            // Upcoming Events Section
            Text(
              'Upcoming Events',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...upcomingEvents.map((event) => Text(
                  '• $event',
                  style: TextStyle(fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
