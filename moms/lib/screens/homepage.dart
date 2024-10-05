import 'package:flutter/material.dart';
import 'package:healthy_moms/screens/chats.dart';
import 'package:healthy_moms/screens/community_forum.dart';
import 'package:healthy_moms/screens/consultation.dart';
import 'package:healthy_moms/screens/meals_screen.dart';
import 'package:healthy_moms/screens/mental_healt_resources.dart';
import 'package:healthy_moms/screens/pregnancy_tracker.dart';
import 'package:healthy_moms/screens/profile.dart';
import 'package:healthy_moms/screens/resources.dart';
import 'package:healthy_moms/screens/settings.dart';
// import 'package:moms/screens/chats.dart';
// import 'package:moms/screens/community_forum.dart';
// import 'package:moms/screens/consultation.dart';
// import 'package:moms/screens/meals_screen.dart';
// import 'package:moms/screens/mental_healt_resources.dart';
// import 'package:moms/screens/pregnancy_tracker.dart';
// import 'package:moms/screens/profile.dart';
// import 'package:moms/screens/resources.dart';
// import 'package:moms/screens/settings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ResourcesScreen(),
    AIChatScreen(),
    MealPlanCalendar(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 // Only show AppBar on Home screen
          ? AppBar(
              backgroundColor: Colors.purple,
              leading: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                  'assets/images/profile.jpeg',
                ),
              ),
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi,',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  Text(
                    'Nady',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        // Handle notification tap
                      },
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: const Text(
                          '2',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScreen()));
                  },
                ),
              ],
            )
          : null, // Set AppBar to null for other screens
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(
                FontAwesomeIcons.robot), // Change this to your ChatGPT icon
            label: 'ChatGPT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            label: 'Meals Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1.0,
            padding: EdgeInsets.all(16),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              FeatureCard(
                title: 'Pregnancy Tracker',
                description: 'Get tailored content',
                icon: Icons.calendar_today,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PregnancyTrackerScreen(
                              currentWeek: 4,
                            )),
                  );
                },
              ),
              FeatureCard(
                title: 'Multilingual Support',
                description: 'Multiple languages',
                icon: Icons.language,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              ),
              FeatureCard(
                title: 'Mental Health',
                description: 'Self-assessment tools',
                icon: Icons.psychology,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MentalHealthScreen()),
                  );
                },
              ),
              FeatureCard(
                title: 'Community Forum',
                description: 'Connect with others',
                icon: Icons.forum,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommunityForumScreen()),
                  );
                },
              ),
              FeatureCard(
                title: 'Consultations',
                description: 'Talk to experts',
                icon: Icons.medical_services,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ConsultationsPage()),
                  );
                },
              ),
              FeatureCard(
                title: 'Emergency Ambulance',
                description: 'Call for immediate help',
                icon: Icons.local_hospital,
                onTap: () {
                  // Implement emergency ambulance call functionality
                  // This could open a dialer with the emergency number pre-filled
                  // or trigger an immediate call to emergency services
                },
              ),
              FeatureCard(
                title: 'Emergency Calls',
                description: 'Quick access to help',
                icon: Icons.phone,
                onTap: () {
                  // Implement emergency calls functionality
                  // This could show a list of emergency numbers
                  // or provide quick dial options for different services
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              child: const Text(
                'Join Our Community',
                style: TextStyle(color: Colors.purple, fontSize: 18),
              ),
              onPressed: () {
                // Implement registration/login functionality
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback? onTap;

  const FeatureCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.purple),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
