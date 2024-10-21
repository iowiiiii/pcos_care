import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../../models/user_data_model.dart';

class FinishSetupScreen extends StatefulWidget {
  final String name;
  final UserData userData;

  FinishSetupScreen({required this.name, required this.userData});

  @override
  _FinishSetupScreenState createState() => _FinishSetupScreenState();
}

class _FinishSetupScreenState extends State<FinishSetupScreen> {
  @override
  void initState() {
    super.initState();
    // Automatically navigate to the home screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userData: widget.userData,
            symptoms: widget.userData.symptoms ?? [], // Use an empty list if null
            recommendations: [],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 100),
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
    );
  }
}
