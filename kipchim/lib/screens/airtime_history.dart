import 'package:flutter/material.dart';

class AirtimeHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> airtimeHistory = [
    {'phone': '0713295911', 'amount': '100', 'date': 'Tue July 4, 15:35'},
    {'phone': '0745137129', 'amount': '150', 'date': 'Tue July 4, 15:35'},
    {'phone': '0740371089', 'amount': '70', 'date': 'Tue July 4, 15:35'},
    {'phone': '0745137219', 'amount': '30', 'date': 'Tue July 4, 15:35'},
    {'phone': '0723541249', 'amount': '60', 'date': 'Tue July 4, 15:35'},
    {'phone': '0701371290', 'amount': '75', 'date': 'Tue July 4, 15:35'},
    {'phone': '073000299', 'amount': '20', 'date': 'Tue July 4, 15:35'},
    {'phone': '0725787357', 'amount': '35', 'date': 'Tue July 4, 15:35'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("Airtime history"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My airtime history",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: airtimeHistory.length,
                itemBuilder: (context, index) {
                  final item = airtimeHistory[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.phone_android, color: Colors.purple),
                      title: Text(item['phone']!),
                      subtitle: Text(item['date']!),
                      trailing: Text(
                        "+Kes ${item['amount']}",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
