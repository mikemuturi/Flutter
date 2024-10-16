import 'package:flutter/material.dart';

class LoanHistoryScreen extends StatelessWidget {
  // Sample loan history data
  final List<Map<String, String>> loanHistory = [
    {'date': 'Tue July 4, 16:35', 'amount': '-Kes 7680'},
    {'date': 'Tue July 5, 17:39', 'amount': '-Kes 1800'},
    {'date': 'Tue July 6, 17:35', 'amount': '-Kes 3800'},
    {'date': 'Tue July 7, 16:50', 'amount': '-Kes 3200'},
    {'date': 'Tue July 8, 17:35', 'amount': '-Kes 1280'},
    {'date': 'Tue July 9, 15:35', 'amount': '-Kes 2180'},
    {'date': 'Tue July 10, 15:35', 'amount': '-Kes 1830'},
    {'date': 'Tue July 8, 17:35', 'amount': '-Kes 1280'},
    {'date': 'Tue July 9, 15:35', 'amount': '-Kes 2180'},
    {'date': 'Tue July 10, 15:35', 'amount': '-Kes 1830'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Past loans'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My loan history',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: loanHistory.length,
                itemBuilder: (context, index) {
                  return LoanHistoryItem(
                    date: loanHistory[index]['date']!,
                    amount: loanHistory[index]['amount']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoanHistoryItem extends StatelessWidget {
  final String date;
  final String amount;

  LoanHistoryItem({required this.date, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(Icons.access_time, color: Colors.blue),
        ),
        title: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
