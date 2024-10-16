import 'package:flutter/material.dart';
import 'package:kipchim/pages/dashboard.dart';
import 'package:kipchim/pages/home.dart';
import 'package:kipchim/screens/airtime.dart';
import 'package:kipchim/screens/airtime_history.dart';
import 'package:kipchim/screens/kilos.dart';
import 'package:kipchim/screens/loans.dart';
import 'package:kipchim/screens/onboarding.dart';
import 'package:kipchim/screens/past_loans.dart';
import 'package:kipchim/screens/past_transactions.dart';
import 'package:kipchim/screens/profile.dart';
import 'package:kipchim/screens/send_money.dart';
import 'package:kipchim/screens/splash.dart';

void main() {
  runApp(KipchimchimApp());
}

class KipchimchimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kipchimchim Group',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
