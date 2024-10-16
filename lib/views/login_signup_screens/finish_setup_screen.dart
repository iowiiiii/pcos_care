import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../../models/user_data_model.dart';

class FinishSetupScreen extends StatelessWidget {
  final String name;
  final UserData userData;
  FinishSetupScreen({required this.name, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 100),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  userData: userData,
                  symptoms: userData.symptoms,
                  recommendations: [],
                ),
              ),
            );
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  "We're setting up your personalized calendar",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'This may take a while',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
