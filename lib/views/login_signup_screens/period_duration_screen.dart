import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../controller/csv_manager.dart';
import '../../controller/step_progress_indicator.dart';
import 'cycle_length_screen.dart';

class PeriodDurationScreen extends StatefulWidget {
  final String name;

  PeriodDurationScreen({required this.name, required double bmi});

  @override
  _PeriodDurationScreenState createState() => _PeriodDurationScreenState();
}

class _PeriodDurationScreenState extends State<PeriodDurationScreen> {
  int selectedPeriodLength = 1;

  List<int> duration = List.generate(31, (index) => index + 1);

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
        backgroundColor: Color.fromRGBO(230, 230, 250, 1),
      ),
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              StepProgressIndicator(currentStep: 5),
              SizedBox(height: 20), 
              Text(
                'How long does your period usually last?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 50,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          selectedPeriodLength = index + 1;
                        });
                      },
                      children: List.generate(duration.length, (index) {
                        return Center(child: Text('${duration[index]} days')); 
                      }),
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    List<dynamic> periodData = [selectedPeriodLength, widget.name];

                    CSVManager csvManager = CSVManager();
                    await csvManager.addToCSV(periodData);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CycleLengthScreen(name: widget.name),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 111, 97, 1),
                  ),
                  child: Text('Next', style: TextStyle(color: Colors.white70)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
