import 'package:flutter/material.dart';
import 'package:kipchim/screens/airtime.dart';
import 'package:kipchim/screens/kilos.dart';
import 'package:kipchim/screens/loans.dart';
import 'package:kipchim/screens/profile.dart';
import 'package:kipchim/screens/send_money.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the back arrow
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/farm.jpeg'), // Replace with your image asset
              radius: 16,
            ),
            SizedBox(width: 8),
            Text('Michael', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: DashboardScreenContent(), // Using the new widget here
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue[800],
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Loans'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Kgs'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (index) {
        // Handle navigation based on the selected index
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(
                context, '/home'); // Adjust route names accordingly
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoanRequestScreen()),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyKgsScreen()),
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
            break;
        }
      },
    );
  }
}

class DashboardScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInfoCards(context),
        _buildQuickActions(context),
        _buildRecentTransactions(),
      ],
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _buildInfoCard(
                      context, 'My weight in Kgs', '200 kgs', Icons.scale)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildInfoCard(context, 'Total earnings',
                      'Kes. 32,000', Icons.monetization_on)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _buildInfoCard(context, 'Total borrowing',
                      'Kes. 7,700', Icons.account_balance)),
              SizedBox(width: 16),
              Expanded(
                  child: _buildInfoCard(
                      context, 'Loan limit', 'Kes. 32,000', Icons.trending_up)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String title, String value, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Handle tap event for info card
        print('Tapped on $title');
        // Add navigation logic if needed
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue[800]),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                Text(value,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionButton(context, 'My Kgs', Icons.scale, MyKgsScreen()),
          _buildActionButton(
              context, 'Loans', Icons.account_balance, LoanRequestScreen()),
          _buildActionButton(
              context, 'Send money', Icons.send, SendMoneyScreen()),
          _buildActionButton(
              context, 'Buy Airtime', Icons.phone_android, AirtimeScreen()),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () {
        // Handle tap event for action button
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        ); // Navigate to respective screen
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[700],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Recent Transactions',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('View all', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildTransactionItem(
                      'Airtime', 'Wed July 3, 17:35', '-Kes 100'),
                  _buildTransactionItem(
                      'Loan', 'Tue July 3, 17:35', '-Kes 20,000'),
                  _buildTransactionItem(
                      'Send money', 'Tue July 3, 17:35', '-Kes 1,100'),
                  _buildTransactionItem(
                      'Airtime', 'Wed July 3, 17:35', '-Kes 100'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(String title, String date, String amount) {
    return ListTile(
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }
}
