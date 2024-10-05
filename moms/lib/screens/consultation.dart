import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Booking {
  final String doctorName;
  final DateTime dateTime;

  Booking({required this.doctorName, required this.dateTime});
}

class ConsultationsPage extends StatefulWidget {
  @override
  _ConsultationsPageState createState() => _ConsultationsPageState();
}

class _ConsultationsPageState extends State<ConsultationsPage> {
  List<Booking> bookings = [];

  void addBooking(Booking booking) {
    setState(() {
      bookings.add(booking);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.purple),
        ),
        title: Text('Book Consultation',
            style: TextStyle(color: Colors.purple, fontSize: 22)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.list, color: Colors.purple),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyBookingsPage(bookings: bookings),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.deepPurple],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Choose Your Specialist',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    ConsultationCard(
                      name: 'Dr. Aisha Omondi',
                      specialty: 'Obstetrician',
                      imageUrl: 'assets/doctor1.png',
                      rating: 4.8,
                      onBookingConfirmed: addBooking,
                    ),
                    ConsultationCard(
                      name: 'Nurse Grace Mutua',
                      specialty: 'Midwife',
                      imageUrl: 'assets/nurse1.png',
                      rating: 4.9,
                      onBookingConfirmed: addBooking,
                    ),
                    ConsultationCard(
                      name: 'Dr. John Kimani',
                      specialty: 'Pediatrician',
                      imageUrl: 'assets/doctor2.png',
                      rating: 4.7,
                      onBookingConfirmed: addBooking,
                    ),
                    ConsultationCard(
                      name: 'Dr. Sarah Ochieng',
                      specialty: 'Mental Health Specialist',
                      imageUrl: 'assets/doctor3.png',
                      rating: 4.6,
                      onBookingConfirmed: addBooking,
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
}

class ConsultationCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String imageUrl;
  final double rating;
  final Function(Booking) onBookingConfirmed;

  const ConsultationCard({
    Key? key,
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.onBookingConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(imageUrl),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(specialty,
                          style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          Text(' $rating',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text(
                'Book Consultation',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              onPressed: () => _showBookingDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BookingDialog(
            name: name, onBookingConfirmed: onBookingConfirmed);
      },
    );
  }
}

class BookingDialog extends StatefulWidget {
  final String name;
  final Function(Booking) onBookingConfirmed;

  const BookingDialog({
    Key? key,
    required this.name,
    required this.onBookingConfirmed,
  }) : super(key: key);

  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Book Consultation with ${widget.name}'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(selectedDate == null
                ? 'Select Date'
                : DateFormat('MMM d, yyyy').format(selectedDate!)),
            onTap: () => _selectDate(context),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            title: Text(selectedTime == null
                ? 'Select Time'
                : selectedTime!.format(context)),
            onTap: () => _selectTime(context),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text(
            'Confirm Booking',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
          ),
          onPressed: (selectedDate != null && selectedTime != null)
              ? () {
                  final bookingDateTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );
                  widget.onBookingConfirmed(Booking(
                    doctorName: widget.name,
                    dateTime: bookingDateTime,
                  ));
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Booking confirmed!')),
                  );
                }
              : null,
        ),
      ],
    );
  }
}

class MyBookingsPage extends StatelessWidget {
  final List<Booking> bookings;

  const MyBookingsPage({Key? key, required this.bookings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 34,
            )),
        title: Text(
          'My Bookings',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return ListTile(
            title: Text(booking.doctorName),
            subtitle: Text(
                DateFormat('MMM d, yyyy - h:mm a').format(booking.dateTime)),
            leading: Icon(Icons.calendar_today),
          );
        },
      ),
    );
  }
}
