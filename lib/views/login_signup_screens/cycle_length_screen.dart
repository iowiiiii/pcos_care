import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controller/step_progress_indicator.dart';
import 'last_period_screen.dart';

class CycleLengthScreen extends StatefulWidget {
  final String name;

  CycleLengthScreen({required this.name});

  @override
  _CycleLengthScreenState createState() => _CycleLengthScreenState();
}

class _CycleLengthScreenState extends State<CycleLengthScreen> {
  int selectedCycleLength = 1;
  List<int> cycle = List.generate(100, (index) => index + 1);

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
        title: Text('Setup Your Profile', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(230, 230, 250, 100),
      ),
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 100),
        child:Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            StepProgressIndicator(currentStep: 6),
            SizedBox(height: 200),
            Text('How long does your cycle last?', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: CupertinoPicker(
                  itemExtent: 50,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedCycleLength = index + 1;
                    });
                  },
                  children: List.generate(100, (index) {
                    return Center(child: Text('${index + 1}'));
                  }),
                ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LastPeriodScreen(name: widget.name)),
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