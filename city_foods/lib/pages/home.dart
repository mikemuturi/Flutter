import 'package:flutter/material.dart';
import 'package:city_foods/screens/food_detail.dart';
import 'package:city_foods/screens/vendor_profile.dart'; // Ensure this import is correct

class HomePage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchRecommendedFoods() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return List.generate(
      5,
      (index) => {
        'name': 'Food Item $index',
        'image': 'https://images.unsplash.com/photo-1546069901-eacef0df6022',
        'price': 'KSh ${((index + 1) * 500).toString()}',
        'rating': '${(index % 5) + 1}.0',
        'description': 'Delicious food item description here.',
        'vendor': 'Vendor ${index + 1}',
        'deliveryTime': '${(index % 3) + 30} mins',
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchPreviousOrders() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return List.generate(
      20,
      (index) => {
        'name': 'Food Item $index',
        'image': 'https://images.unsplash.com/photo-1546069901-eacef0df6022',
        'price': 'KSh ${((index + 1) * 500).toString()}',
        'rating': '${(index % 5) + 1}.0',
        'vendor': 'Vendor ${index + 1}',
        'description': 'Delicious food item description here.',
        'deliveryTime': '${(index % 3) + 30} mins',
      },
    );
  }

  List<Map<String, String>> fetchVendors() {
    return List.generate(
      5,
      (index) => {
        'image': 'https://via.placeholder.com/150',
        'name': 'Vendor ${index + 1}',
        'slogan': 'Slogan for Vendor ${index + 1}',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // User Profile Section
          Container(
            padding: EdgeInsets.all(16.0),
            color: const Color.fromRGBO(238, 238, 238, 1),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.jpeg'),
                ),
                SizedBox(width: 16),
                Text(
                  'Mike Muturi',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Landing Image with Overlay Text
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200.0,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1546069901-eacef0df6022',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 200.0,
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Text(
                    'Konza City Foods',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          // Recommended for You Section
          // Recommended for You Section
          FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchRecommendedFoods(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                final recommendedFoods = snapshot.data!;
                return Container(
                  height: 180.0,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Recommended for You',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: recommendedFoods.map((food) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodDetailScreen(
                                        foodName: food['name'] ?? 'Unknown',
                                        foodImage: food['image'] ??
                                            'https://via.placeholder.com/150',
                                        foodPrice: food['price'] ?? 'Unknown',
                                        foodRating: food['rating'] ?? '0.0',
                                        foodDescription: food['description'] ??
                                            'No description',
                                        vendorName: food['vendor'] ?? 'Unknown',
                                        deliveryTime:
                                            food['deliveryTime'] ?? 'Unknown',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 160.0,
                                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            food['image'] ??
                                                'https://via.placeholder.com/150',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    food['name'] ?? 'Unknown',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    food['price'] ?? 'Unknown',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    food['vendor'] ?? 'Unknown',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 16,
                                                      ),
                                                      SizedBox(width: 4),
                                                      Text(
                                                        food['rating'] ?? '0.0',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),

          SizedBox(height: 16),

          // Vendor Section
          Container(
            height: 120.0,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: FutureBuilder<List<Map<String, String>>>(
              future: Future.value(
                  fetchVendors()), // Use Future.value for demo purposes
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  final vendors = snapshot.data!;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: vendors.map((vendor) {
                        return InkWell(
                          onTap: () {
                            print(
                                'Vendor tapped: ${vendor['name']}'); // Debugging line
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VendorProfileScreen(
                                  vendorName: vendor['name'] ?? 'Unknown',
                                  vendorSlogan: vendor['slogan'] ?? 'No slogan',
                                  vendorImage: '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 120.0,
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Image.network(
                                      vendor['image'] ??
                                          'https://via.placeholder.com/150',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  vendor['name'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .green, // Green color for vendor name
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ),

          // Previous Orders Section
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchPreviousOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recent orders'));
                } else {
                  final previousOrders = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          'Recent Orders',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: previousOrders.length,
                          itemBuilder: (context, index) {
                            final order = previousOrders[index];
                            return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 16.0),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(8.0),
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    order['image'] ??
                                        'https://via.placeholder.com/150',
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        order['name'] ?? 'Unknown',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      order['price'] ?? 'Unknown',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        order['vendor'] ?? 'Unknown',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      order['rating'] ?? '0.0',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FoodDetailScreen(
                                        foodName: order['name'] ?? 'Unknown',
                                        foodImage: order['image'] ??
                                            'https://via.placeholder.com/150',
                                        foodPrice: order['price'] ?? 'Unknown',
                                        foodRating: order['rating'] ?? '0.0',
                                        foodDescription: order['description'] ??
                                            'No description',
                                        vendorName:
                                            order['vendor'] ?? 'Unknown',
                                        deliveryTime:
                                            order['deliveryTime'] ?? 'Unknown',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
