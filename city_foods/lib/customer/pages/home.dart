import 'package:city_foods/vendor/pages/vendor_home.dart';
import 'package:flutter/material.dart';
import 'package:city_foods/customer/screens/food_detail.dart';
import 'package:city_foods/customer/screens/vendor_profile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildAppBar(context),
          Expanded(
            child: ListView(
              children: [
                _buildLandingImage(),
                _buildRecommendedSection(),
                _buildVendorSection(),
                _buildRecentOrdersSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: const Color.fromRGBO(238, 238, 238, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/profile.jpeg'),
          ),
          const Text(
            'CityFoods',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          Row(
            children: const [
              Icon(Icons.search, color: Colors.green, size: 30),
              SizedBox(width: 16),
              Icon(Icons.notifications, color: Colors.green, size: 30),
              SizedBox(width: 16),
              Icon(Icons.shopping_cart, color: Colors.green, size: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLandingImage() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1546069901-eacef0df6022',
            fit: BoxFit.cover,
            height: 150.0,
            width: double.infinity,
          ),
          Container(
            height: 150.0,
            color: Colors.black.withOpacity(0.5),
            alignment: Alignment.center,
            child: const Text(
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
    );
  }

  Widget _buildRecommendedSection() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchRecommendedFoods(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final recommendedFoods = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Recommended for You',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedFoods.length,
                itemBuilder: (context, index) =>
                    _buildFoodCard(context, recommendedFoods[index]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFoodCard(BuildContext context, Map<String, dynamic> food) {
    return InkWell(
      onTap: () => _navigateToFoodDetail(context, food),
      child: Container(
        width: 160.0,
        margin: const EdgeInsets.all(8.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  food['image'] ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food['name'] ?? 'Unknown',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      food['price'] ?? 'Unknown',
                      style: const TextStyle(fontSize: 14, color: Colors.green),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(food['rating'] ?? '0.0'),
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
  }

  Widget _buildVendorSection() {
    return FutureBuilder<List<Map<String, String>>>(
      future: Future.value(_fetchVendors()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final vendors = snapshot.data!;
        return SizedBox(
          height: 120.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vendors.length,
            itemBuilder: (context, index) =>
                _buildVendorCard(context, vendors[index]),
          ),
        );
      },
    );
  }

  Widget _buildVendorCard(BuildContext context, Map<String, String> vendor) {
    return InkWell(
      onTap: () => _navigateToVendorProfile(context, vendor),
      child: Container(
        width: 120.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                child: Image.network(
                  vendor['image'] ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              vendor['name'] ?? 'Unknown',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentOrdersSection() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchPreviousOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recent orders'));
        }

        final previousOrders = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Recent Orders',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: previousOrders.length,
              itemBuilder: (context, index) =>
                  _buildOrderCard(context, previousOrders[index]),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            order['image'] ?? 'https://via.placeholder.com/150',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text(order['name'] ?? 'Unknown',
                    style: const TextStyle(fontWeight: FontWeight.bold))),
            Text(order['price'] ?? 'Unknown',
                style: const TextStyle(color: Colors.green)),
          ],
        ),
        subtitle: Row(
          children: [
            Expanded(child: Text(order['vendor'] ?? 'Unknown')),
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const SizedBox(width: 4),
            Text(order['rating'] ?? '0.0'),
          ],
        ),
        onTap: () => _navigateToFoodDetail(context, order),
      ),
    );
  }

  void _navigateToFoodDetail(BuildContext context, Map<String, dynamic> food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailScreen(
          foodName: food['name'] ?? 'Unknown',
          foodImage: food['image'] ?? 'https://via.placeholder.com/150',
          foodPrice: food['price'] ?? 'Unknown',
          foodRating: food['rating'] ?? '0.0',
          foodDescription: food['description'] ?? 'No description',
          vendorName: food['vendor'] ?? 'Unknown',
          deliveryTime: food['deliveryTime'] ?? 'Unknown',
        ),
      ),
    );
  }

  void _navigateToVendorProfile(
      BuildContext context, Map<String, String> vendor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VendorProfileScreen(
          vendorName: vendor['name'] ?? 'Unknown',
          vendorSlogan: vendor['slogan'] ?? 'No slogan',
          vendorImage: vendor['image'] ?? '',
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchRecommendedFoods() async {
    await Future.delayed(const Duration(seconds: 2));
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

  Future<List<Map<String, dynamic>>> _fetchPreviousOrders() async {
    await Future.delayed(const Duration(seconds: 2));
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

  List<Map<String, String>> _fetchVendors() {
    return List.generate(
      5,
      (index) => {
        'image': 'https://via.placeholder.com/150',
        'name': 'Vendor ${index + 1}',
        'slogan': 'Slogan for Vendor ${index + 1}',
      },
    );
  }
}
