import 'package:flutter/material.dart';

class VendorCard extends StatelessWidget {
  final String logoUrl;
  final String vendorName;

  VendorCard({required this.logoUrl, required this.vendorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Adjust width as needed
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                logoUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons
                      .error); // Display an error icon if the image fails to load
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                vendorName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
