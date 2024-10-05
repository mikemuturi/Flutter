import 'package:city_foods/customer/screens/splash.dart';
import 'package:city_foods/vendor/pages/dump.dart';
import 'package:city_foods/vendor/pages/vendor_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'City Food',
        // theme: new ThemeData(scaffoldBackgroundColor: const Color.fromARGB(176, 9, 59, 2)),
        home: VendorHomePage());
  }
}
