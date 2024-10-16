import 'package:flutter/material.dart';
import 'package:kipchim/screens/past_transactions.dart';

class SendMoneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send money'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.navigate_before),
          onPressed: () {
            // Add back navigation logic
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Balance display section
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet_outlined,
                            color: Colors.yellow[700]),
                        SizedBox(width: 8),
                        Text('Balance',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text(
                      'Kes. 25,000',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Transaction history button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.grey),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionHistoryScreen()));
              },
              icon: Icon(Icons.access_time, color: Colors.black),
              label: Text('Transaction history',
                  style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 24),
            // Send money form
            Text(
              'Send money',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Send money with M-Pesa to another number.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 24),
            // Phone number input
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            // Amount input
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Submit transaction logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
