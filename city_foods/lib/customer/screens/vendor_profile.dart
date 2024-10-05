import 'package:city_foods/customer/screens/food_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates
import 'package:table_calendar/table_calendar.dart';

class VendorProfileScreen extends StatefulWidget {
  VendorProfileScreen({
    required this.vendorName,
    required this.vendorSlogan,
    required String vendorImage,
  });

  final String vendorName;
  final String vendorSlogan;

  @override
  _VendorProfileScreenState createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Widget to build the list of meals for a given day
  Widget _buildMealsList(DateTime day) {
    // Get the day name
    String dayName = DateFormat('EEEE').format(day); // EEEE gives full day name

    // Example meal data, replace with actual data
    final List<Map<String, dynamic>> meals = List.generate(
        5,
        (index) => {
              'name': 'Meal ${index + 1} of $dayName',
              'price': 'KES ${(index + 1) * 500}', // Updated to KES
              'rating': (index + 1) * 0.5,
              'description':
                  'This is a description of Meal ${index + 1} of $dayName. It\'s delicious and healthy.',
              'image': 'https://via.placeholder.com/150',
              'deliveryTime': '${30 + index * 5} mins',
            });

    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the FoodDetailScreen when a meal is tapped
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetailScreen(
                  foodName: meal['name'],
                  foodImage: meal['image'],
                  foodPrice: meal['price'].replaceAll(
                      'KES ', ''), // Clean KES symbol for numeric value
                  foodRating: meal['rating'].toString(),
                  foodDescription: meal['description'],
                  vendorName: widget.vendorName,
                  deliveryTime: meal['deliveryTime'],
                ),
              ),
            );
          },
          child: MealCard(
            imageUrl: meal['image'],
            name: meal['name'],
            price: meal['price'],
            rating: meal['rating'],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vendorName),
        backgroundColor: Colors.green, // Customize AppBar color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Logo or Image
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Vendor Profile Image
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150', // Vendor logo placeholder
                  ),
                  backgroundColor:
                      Colors.grey.shade200, // Light background for logo
                ),

                // Spacing between profile image and text
                SizedBox(width: 10),

                // Vendor Name and Slogan
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.vendorName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.vendorSlogan,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // Notification Icon with Red Dot
                Stack(
                  children: [
                    Icon(Icons.notifications, size: 30, color: Colors.black),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1', // Notification count
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 24),

            // Calendar with Day of the Week and Date
            TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.week,
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekendStyle: TextStyle(color: Colors.red),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Meal list for the selected day
            Expanded(
              child: _selectedDay == null
                  ? Center(child: Text('Select a day to view meals'))
                  : _buildMealsList(_selectedDay!),
            ),
          ],
        ),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  MealCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.rating,
  });

  final String imageUrl;
  final String name;
  final String price;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16),
                      SizedBox(width: 4),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
