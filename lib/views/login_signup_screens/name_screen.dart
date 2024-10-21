import 'package:flutter/material.dart';
import '../../controller/step_progress_indicator.dart';
import 'birthday_screen.dart';
import '../../controller/csv_manager.dart';

class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool _isNameValid = true;

  CSVManager csvManager = CSVManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Setup Your Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(230, 230, 250, 100),
      ),
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              StepProgressIndicator(currentStep: 1),
              SizedBox(height: 150),
              Text(
                'What is your name?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              TextField(
                textAlign: TextAlign.center,
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(70, 80, 90, 0.2),
                  hintText: 'Your Name',
                  errorText: _isNameValid ? null : 'Please enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_nameController.text.isEmpty) {
                      setState(() {
                        _isNameValid = false;
                      });
                    } else {
                      setState(() {
                        _isNameValid = true;
                      });

                      // Initialize the CSV with the user's name
                      await csvManager.initializeCSV(_nameController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BirthdayScreen(name: _nameController.text),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 111, 97, 1),
                  ),
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
