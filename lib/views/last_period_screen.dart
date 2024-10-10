import 'package:flutter/material.dart';
import '../controller/step_progress_indicator.dart';
import 'finish_setup_screen.dart';

class LastPeriodScreen extends StatelessWidget {
 final String name;

 LastPeriodScreen({required this.name});

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
       backgroundColor: Color.fromRGBO(230, 230, 250, 100),
     ),
     body: Material(
       color: Color.fromRGBO(230, 230, 250, 100),
       child: Padding(
         padding: const EdgeInsets.all(16.0),
         child: Column(
         children: [
           SizedBox(height: 20),
           StepProgressIndicator(currentStep: 7),
           SizedBox(height: 200),
           Text('When was your last period?', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
           SizedBox(height: 50),
           Spacer(),
           SizedBox(
             width: double.infinity,
             child: ElevatedButton(
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => FinishSetupScreen(name: name)),
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