import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyKgsScreen extends StatefulWidget {
  @override
  _MyKgsScreenState createState() => _MyKgsScreenState();
}

class _MyKgsScreenState extends State<MyKgsScreen> {
  int selectedMonthIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.navigate_before, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('My kgs', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildMonthSelector(),
          Expanded(
            child: _buildKgsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthSelector() {
    List<String> months = ['Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: months.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedMonthIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  '${months[index]} 2024',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: index == selectedMonthIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: index == selectedMonthIndex
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKgsList() {
    // This would typically come from a database or API
    Map<int, List<Map<String, dynamic>>> kgsDataByMonth = {
      0: [
        // July
        {"kgs": 320, "rate": 24, "amount": 7680, "date": "Tue July 4, 15:35"},
        {"kgs": 320, "rate": 22, "amount": 7040, "date": "Tue July 4, 15:35"},
        {"kgs": 160, "rate": 21, "amount": 3360, "date": "Tue July 5, 16:55"},
        {"kgs": 120, "rate": 20, "amount": 2400, "date": "Tue July 4, 15:35"},
        {"kgs": 320, "rate": 24, "amount": 7680, "date": "Tue July 4, 15:35"},
        {"kgs": 320, "rate": 22, "amount": 7040, "date": "Tue July 4, 15:35"},
        {"kgs": 160, "rate": 21, "amount": 3360, "date": "Tue July 5, 16:55"},
        {"kgs": 120, "rate": 20, "amount": 2400, "date": "Tue July 4, 15:35"},
      ],
      1: [
        // August
        {"kgs": 280, "rate": 23, "amount": 6440, "date": "Wed Aug 2, 14:30"},
        {"kgs": 300, "rate": 22, "amount": 6600, "date": "Thu Aug 10, 16:45"},
        {"kgs": 320, "rate": 24, "amount": 7680, "date": "Tue July 4, 15:35"},
        {"kgs": 320, "rate": 22, "amount": 7040, "date": "Tue July 4, 15:35"},
        {"kgs": 160, "rate": 21, "amount": 3360, "date": "Tue July 5, 16:55"},
        {"kgs": 120, "rate": 20, "amount": 2400, "date": "Tue July 4, 15:35"},
      ],
      // Add data for other months here
    };

    List<Map<String, dynamic>> currentMonthData =
        kgsDataByMonth[selectedMonthIndex] ?? [];

    return ListView.builder(
      itemCount: currentMonthData.length,
      itemBuilder: (context, index) {
        var item = currentMonthData[index];
        return _buildKgsListItem(item);
      },
    );
  }

  Widget _buildKgsListItem(Map<String, dynamic> item) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[100],
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.eco, color: Colors.green),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item["kgs"]} kgs x ${item["rate"]}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  item["date"],
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            'Kes ${NumberFormat("#,###").format(item["amount"])}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
