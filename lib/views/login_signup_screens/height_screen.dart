import 'package:flutter/material.dart';
import 'period_duration_screen.dart';
import '../../controller/csv_manager.dart';
import '../../controller/step_progress_indicator.dart';

class HeightScreen extends StatefulWidget {
  final String name;
  final double weight;
  final int age;

  HeightScreen({required this.name, required this.weight, required this.age});

  @override
  _HeightScreenState createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  bool isCmSelected = true;
  final TextEditingController _heightController = TextEditingController();
  double? bmi;
  bool _isHeightValid = true;  // To track height validity

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
        backgroundColor: Color.fromRGBO(230, 230, 250, 100),
        centerTitle: true,
      ),
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 100),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              StepProgressIndicator(currentStep: 4),
              SizedBox(height: 200),
              Text(
                'Enter your height:',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton(
                    label: 'cm',
                    isSelected: isCmSelected,
                    onTap: () {
                      setState(() {
                        isCmSelected = true;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  _buildToggleButton(
                    label: 'ft',
                    isSelected: !isCmSelected,
                    onTap: () {
                      setState(() {
                        isCmSelected = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.center,
                controller: _heightController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(70, 80, 90, 245),
                  hintText: 'Your Height (e.g., 180 or 6\'0")',
                  errorText: _isHeightValid ? null : 'Please enter a valid height',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                keyboardType: TextInputType.text, // Allow text input for the height
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isHeightValid = _validateHeight(_heightController.text);
                    });

                    if (_isHeightValid) {
                      double height;
                      if (isCmSelected) {
                        height = double.parse(_heightController.text);
                      } else {
                        final input = _heightController.text.replaceAll("'", "").trim();
                        height = double.parse(input);
                      }

                      double heightInMeters = isCmSelected ? height / 100 : height * 0.3048;
                      bmi = calculateBMI(widget.weight, heightInMeters); // Calculate BMI

                      if (bmi != null) {
                        CSVManager csvManager = CSVManager();
                        await csvManager.addHeightAndBmiToCSV(widget.name, heightInMeters, bmi!);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PeriodDurationScreen(name: widget.name, bmi: bmi!),
                          ),
                        );
                      }
                    }
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

  bool _validateHeight(String input) {
    if (isCmSelected) {
      return double.tryParse(input) != null;
    } else {
      return input.contains("'") && input.split("'").length == 2;
    }
  }

  double calculateBMI(double weight, double height) {
    if (height > 0) {
      return weight / (height * height);
    }
    return 0;
  }

  Widget _buildToggleButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromRGBO(255, 111, 97, 100)
              : Colors.white, // Toggle between selected and unselected color
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color.fromRGBO(255, 111, 97, 100), // Border color
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Color.fromRGBO(255, 111, 97, 100),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
