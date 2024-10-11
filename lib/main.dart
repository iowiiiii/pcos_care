import 'package:flutter/material.dart';
import 'views/login_signup_screens/name_screen.dart';

void main() {
  runApp(PCOSCareApp());
}

class PCOSCareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PCOS Care App',
      home: NameScreen(),
      color: Color.fromRGBO(230, 230, 250, 100),
    );
  }
}