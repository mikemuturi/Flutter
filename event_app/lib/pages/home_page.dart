import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF007A37),
        leading: Image.asset(
          'lib/images/Logo.png',
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Contacts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "FAQs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "SignUp",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.login,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      // Button border radius
                    ),
                    elevation: 4, // Elevation
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: Stack(
                children: [
                  Image.asset(
                    "lib/images/city.jpeg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 500,
                  ),
                  Positioned(
                    bottom: 50,
                    left: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Book event easily",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Welcome To Konza Events",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007A37),
                            // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              // Button border radius
                            ),
                            elevation: 4, // Elevation
                          ),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: const Text(
                            "Discover More",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // number of items in each row
                  mainAxisSpacing: 8.0, // spacing between rows
                  crossAxisSpacing: 8.0, // spacing between columns
                ),
                padding: const EdgeInsets.all(8.0), // padding around the grid
                itemCount: items.length, // total number of items
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.blue, // color of grid items
                    child: Center(
                      child: Text(
                        items[index],
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
