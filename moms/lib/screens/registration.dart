// registration_screen.dart
import 'package:flutter/material.dart';
import 'package:healthy_moms/screens/homepage.dart';
import 'package:healthy_moms/screens/login.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, password, dueDate, preferredLanguage;
  DateTime? selectedDate;

  List<String> languages = ['English', 'Swahili', 'Kikuyu', 'Luo', 'Kalenjin'];

  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now().add(Duration(days: 280)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 280)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dueDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Added SafeArea to prevent overlap with system UI
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    // Title
                    const Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    // Name Field with Icon and Border
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your name' : null,
                      onSaved: (value) => name = value,
                    ),
                    SizedBox(height: 10),
                    // Email Field with Icon and Border
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your email' : null,
                      onSaved: (value) => email = value,
                    ),
                    SizedBox(height: 10),
                    // Password Field with Icon and Border
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                      ),
                      obscureText: true,
                      validator: (value) =>
                          value!.length < 6 ? 'Password too short' : null,
                      onSaved: (value) => password = value,
                    ),
                    SizedBox(height: 10),
                    // Due Date Field with Icon and Border
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Due Date',
                        hintText: dueDate ?? 'Select your due date',
                        prefixIcon: Icon(Icons.calendar_today),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0),
                        ),
                      ),
                      onTap: () => _selectDueDate(context),
                      validator: (value) =>
                          dueDate == null ? 'Select your due date' : null,
                    ),
                    SizedBox(height: 10),
                    // Preferred Language Dropdown with Border
                    DropdownButtonFormField<String>(
                      decoration:
                          InputDecoration(labelText: 'Preferred Language'),
                      items: languages.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          preferredLanguage = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Select a language' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple), // Purple button
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Implement registration logic
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      },
                    ),
                    TextButton(
                      // style: TextButton.styleFrom(
                      //     foregroundColor: Colors.purple), // Purple text button
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? "),
                          Text(
                            'Login',
                            style: TextStyle(color: Colors.purple),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
