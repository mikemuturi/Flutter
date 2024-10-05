import 'package:city_foods/customer/pages/order.dart';
import 'package:flutter/material.dart';
import 'package:city_foods/customer/utils/colors.dart'; // Assuming you have a utils/colors.dart file for custom colors

class FoodDetailScreen extends StatelessWidget {
  final String foodName;
  final String foodImage;
  final String foodPrice; // Ensure this is passed without currency symbols
  final String foodRating;
  final String foodDescription;
  final String vendorName;
  final String deliveryTime;

  const FoodDetailScreen({
    required this.foodName,
    required this.foodImage,
    required this.foodPrice,
    required this.foodRating,
    required this.foodDescription,
    required this.vendorName,
    required this.deliveryTime,
  });

  @override
  Widget build(BuildContext context) {
    // Clean price string to ensure it contains only numeric values and decimal points
    final cleanPrice = foodPrice.replaceAll(RegExp('[^0-9.]'), '');
    final price = double.tryParse(cleanPrice) ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(foodName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              foodImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              foodName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Price: KES ${price.toStringAsFixed(2)}', // Display price with KES symbol
              style: TextStyle(fontSize: 18, color: AppColors.primaryGreen),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 24,
                ),
                SizedBox(width: 4),
                Text(
                  foodRating,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              foodDescription,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Vendor: $vendorName',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Text(
              'Delivery time: $deliveryTime',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the OrderPage and pass necessary data including vendorName
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderPage(
                          foodName: foodName,
                          price: price,
                          foodImage: foodImage,
                          toppings:
                              '', // Pass empty string or your desired default value
                          vendorName: vendorName, // Pass vendorName
                        ),
                      ),
                    );
                  },
                  child: Text('Order Now'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.onPrimaryWhite,
                    backgroundColor: AppColors.primaryGreen,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
