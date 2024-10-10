import 'package:flutter/material.dart';
import '../controller/step_progress_indicator.dart';
import 'birthday_screen.dart';

class NameScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

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
        title: Text('Setup Your Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor : Color.fromRGBO(230, 230, 250, 100),
      ),
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 100),
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            StepProgressIndicator(currentStep: 1),
            SizedBox(height: 200),
            Text('What is your name?', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 50),
            TextField(
              textAlign: TextAlign.center,
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(70, 80, 90, 245),
                hintText: 'Your Name',
                border: OutlineInputBorder(),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BirthdayScreen(name: _nameController.text)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(255, 111, 97, 100),
                ),
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}