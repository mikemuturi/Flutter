import 'package:flutter/material.dart';



class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/user.png'), // Replace with actual profile image
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                'Hello Chebet,',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              // Information Cards
              InformationCard(title: "Total Weight", value: "150 kg", icon: Icons.check_circle),
              InformationCard(title: "Total Earnings", value: "Kes. 36,000", icon: Icons.attach_money),
              InformationCard(title: "Total Borrowing", value: "Kes. 7,700", icon: Icons.arrow_downward),
              InformationCard(title: "Loan Limit", value: "Kes. 10,300", icon: Icons.lock_outline),

              SizedBox(height: 24),

              // Other Services Section
              Text(
                'Other services',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),

              // Grid of services
              GridView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                children: [
                  ServiceIcon(title: 'Mobile Money', icon: Icons.mobile_friendly),
                  ServiceIcon(title: 'Airtime', icon: Icons.phone_android),
                  ServiceIcon(title: 'Transfer funds', icon: Icons.swap_horiz),
                  ServiceIcon(title: 'Savings', icon: Icons.savings),
                  ServiceIcon(title: 'Pay Bills', icon: Icons.receipt),
                  ServiceIcon(title: 'Loans', icon: Icons.credit_card),
                  ServiceIcon(title: 'Agent Services', icon: Icons.people),
                  ServiceIcon(title: 'Requests', icon: Icons.support_agent),
                  ServiceIcon(title: 'Statements', icon: Icons.description),
                ],
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

// Information Card Widget
class InformationCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  InformationCard({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(icon, color: Colors.green),
        ],
      ),
    );
  }
}

// Service Icon Widget
class ServiceIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  ServiceIcon({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, size: 30, color: Colors.blue),
        ),
        SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
