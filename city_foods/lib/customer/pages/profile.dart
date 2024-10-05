import 'package:city_foods/customer/pages/menus/faqs.dart';
import 'package:city_foods/customer/pages/menus/help_support.dart';
import 'package:city_foods/customer/pages/menus/myorders.dart';
import 'package:city_foods/customer/pages/menus/notifications.dart';
import 'package:city_foods/customer/pages/menus/payment.dart';
import 'package:city_foods/customer/pages/menus/privacy_policies.dart';
import 'package:city_foods/customer/pages/menus/profile_settings.dart';
import 'package:city_foods/customer/pages/menus/terms_conditions.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Profile Card
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.grey[200],
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/profile.jpeg'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mike Muturi',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'mmuturi@konza.go.ke',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  _buildMenuItem(context, 'My Orders', Icons.shopping_cart,
                      MyOrdersPage()),
                  _buildMenuItem(context, 'Notifications', Icons.notifications,
                      NotificationsPage()),
                  _buildMenuItem(
                      context, 'Payment', Icons.payment, PaymentPage()),
                  _buildMenuItem(
                      context, 'Help & Support', Icons.help, HelpSupportPage()),
                  _buildMenuItem(
                      context, 'FAQs', Icons.question_answer, FAQsPage()),
                  _buildMenuItem(context, 'Profile Settings', Icons.settings,
                      ProfileSettingsPage()),
                  _buildMenuItem(context, 'Privacy and Policies',
                      Icons.privacy_tip, PrivacyPoliciesPage()),
                  _buildMenuItem(context, 'Terms and Conditions',
                      Icons.description, TermsConditionsPage()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
