import 'package:flutter/material.dart';
import 'package:healthy_moms/screens/consultation.dart';
import 'package:healthy_moms/screens/homepage.dart';
import 'package:healthy_moms/screens/profile.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  String? selectedLanguage;

  List<String> languages = ['English', 'Swahili', 'Kikuyu', 'Luo', 'Kalenjin'];

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
              color: Colors.white,
              size: 34,
            )),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        children: [
          _buildCard(
            title: 'Profile',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          _buildCard(
            title: 'Theme',
            onTap: () {
              // Navigate to theme settings screen
            },
          ),
          _buildCard(
            title: 'Notifications',
            child: SwitchListTile(
              title: Text('Enable Notifications'),
              value: notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
          ),
          _buildCard(
            title: 'Preferred Language',
            child: ListTile(
              title: Text('Preferred Language'),
              subtitle: Text(selectedLanguage ?? 'Select Language'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                _selectLanguage(context);
              },
            ),
            onTap: () {
              _selectLanguage(context);
            },
          ),
          _buildCard(
            title: 'My Bookings',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyBookingsPage(
                            bookings: [],
                          )));
            },
          ),
          _buildCard(
            title: 'Privacy Policy',
            onTap: () {
              // Navigate to privacy policy screen
            },
          ),
          _buildCard(
            title: 'Terms of Service',
            onTap: () {
              // Navigate to terms of service screen
            },
          ),
          _buildCard(
            title: 'Help & Support',
            onTap: () {
              // Navigate to help and support screen
            },
          ),
          _buildCard(
            title: 'Log Out',
            onTap: () {
              // Handle log out action
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
      {required String title, GestureTapCallback? onTap, Widget? child}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              if (child != null) child,
            ],
          ),
        ),
      ),
    );
  }

  void _selectLanguage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Preferred Language'),
          content: Container(
            width: double.minPositive,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: languages.length,
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile(
                  title: Text(languages[index]),
                  value: languages[index],
                  groupValue: selectedLanguage,
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value as String?;
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
