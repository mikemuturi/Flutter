import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  final String foodName;
  final double price;
  final String foodImage;
  final String toppings;
  final double deliveryFee;
  final double discount;
  final String vendorName;

  OrderPage({
    required this.foodName,
    required this.price,
    required this.foodImage,
    required this.toppings,
    this.deliveryFee = 5.00,
    this.discount = 0.0,
    required this.vendorName,
  });

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int quantity = 1;
  final TextEditingController _phoneController = TextEditingController();

  double get totalPrice {
    double itemTotal = widget.price * quantity;
    double discountedPrice = itemTotal - widget.discount;
    return discountedPrice + widget.deliveryFee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Summary',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Meal Card
              Card(
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food Image
                    Image.network(
                      widget.foodImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Meal Name and Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.foodName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.orange, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '4.5', // Replace with actual rating if available
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          // Toppings/Accompaniment
                          Text(
                            widget.toppings,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          SizedBox(height: 16),
                          // Quantity Controls
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() {
                                        quantity--;
                                      });
                                    }
                                  },
                                  icon: Icon(Icons.remove_circle_outline),
                                ),
                                Text(
                                  quantity.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  icon: Icon(Icons.add_circle_outline),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                          // Price
                          Text(
                            'KES ${widget.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Total Price and Summary
              SizedBox(height: 30),
              Text(
                "Delivery Fee: KES ${widget.deliveryFee.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 15),
              if (widget.discount > 0)
                Text(
                  "Discount: -KES ${widget.discount.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              SizedBox(height: 20),
              Text(
                "Total Price: KES ${totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              SizedBox(height: 100),

              // Pay Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Show payment dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Payment Confirmation'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'You will pay KES ${totalPrice.toStringAsFixed(2)} to ${widget.vendorName}.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Enter your phone number below to complete the payment:',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: _phoneController,
                              decoration: InputDecoration(
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Handle payment logic here
                            },
                            child: Text(
                              'Pay',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigate back to the order page
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Pay Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
