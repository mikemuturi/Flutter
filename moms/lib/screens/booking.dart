// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';


// class MyBookingsPage extends StatelessWidget {
  
//   final List<Booking> bookings;

//   const MyBookingsPage({Key? key, required this.bookings}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Bookings'),
//         backgroundColor: Colors.purple,
//       ),
//       body: ListView.builder(
//         itemCount: bookings.length,
//         itemBuilder: (context, index) {
//           final booking = bookings[index];
//           return ListTile(
//             title: Text(booking.doctorName),
//             subtitle: Text(DateFormat('MMM d, yyyy - h:mm a').format(booking.dateTime)),
//             leading: Icon(Icons.calendar_today),
//           );
//         },
//       ),
//     );
//   }
// }