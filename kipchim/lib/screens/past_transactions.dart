import 'package:flutter/material.dart';

class TransactionHistoryScreen extends StatelessWidget {
  // Sample transaction data
  final List<Map<String, String>> transactions = [
    {'number': '0713295911', 'amount': '-Kes 390', 'date': 'Tue July 4, 15:35'},
    {
      'number': '0745137129',
      'amount': '-Kes 1500',
      'date': 'Tue July 4, 15:35'
    },
    {
      'number': '0745137129',
      'amount': '-Kes 1600',
      'date': 'Tue July 4, 15:35'
    },
    {
      'number': '0745137129',
      'amount': '-Kes 1300',
      'date': 'Tue July 4, 15:35'
    },
    {'number': '0745137129', 'amount': '-Kes 600', 'date': 'Tue July 4, 15:35'},
    {
      'number': '0745137129',
      'amount': '-Kes 1500',
      'date': 'Tue July 4, 15:35'
    },
    {
      'number': '0745137129',
      'amount': '-Kes 1450',
      'date': 'Tue July 4, 15:35'
    },
    {
      'number': '0745137129',
      'amount': '-Kes 1280',
      'date': 'Tue July 4, 15:35'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction history'),
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
              'My transaction history',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return TransactionItem(
                    number: transactions[index]['number']!,
                    amount: transactions[index]['amount']!,
                    date: transactions[index]['date']!,
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

class TransactionItem extends StatelessWidget {
  final String number;
  final String amount;
  final String date;

  TransactionItem({
    required this.number,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.yellow.shade100,
              child: Icon(Icons.account_balance_wallet_outlined,
                  color: Colors.yellow[700]),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    number,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              amount,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
