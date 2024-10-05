import 'package:flutter/material.dart';

class ProfileDetailsPage extends StatelessWidget {
  final Profile profile;

  ProfileDetailsPage({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.username),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profile.imageUrl),
              radius: 50,
            ),
            SizedBox(height: 16),
            Text(
              'Orders:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ...profile.orders
                .map((order) => Text(order))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class Profile {
  final String username;
  final String imageUrl;
  final List<String> orders;

  Profile({required this.username, required this.imageUrl, required this.orders});
}
