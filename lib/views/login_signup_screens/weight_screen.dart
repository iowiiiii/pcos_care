import 'package:flutter/material.dart';
import 'height_screen.dart';
import '../../controller/csv_manager.dart';
import '../../controller/step_progress_indicator.dart';

class WeightScreen extends StatefulWidget {
  final String name;
  final int age;

  WeightScreen({required this.name, required this.age});

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  bool isKgSelected = true;
  final TextEditingController _weightController = TextEditingController();
  bool _isWeightValid = true; // To track weight validity

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
              StepProgressIndicator(currentStep: 3),
              SizedBox(height: 200),
              Text(
                'Enter your weight:',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToggleButton(
                    label: 'kg',
                    isSelected: isKgSelected,
                    onTap: () {
                      setState(() {
                        isKgSelected = true;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  _buildToggleButton(
                    label: 'lb',
                    isSelected: !isKgSelected,
                    onTap: () {
                      setState(() {
                        isKgSelected = false;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                textAlign: TextAlign.center,
                controller: _weightController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(70, 80, 90, 245),
                  hintText: 'Your Weight',
                  errorText: _isWeightValid ? null : 'Please enter a valid weight',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      _isWeightValid = _validateWeight(_weightController.text);
                    });

                    if (_isWeightValid) {
                      double weight = double.parse(_weightController.text);

                      CSVManager csvManager = CSVManager();

                      // Save the weight in CSV
                      await csvManager.addWeightToCSV(widget.name, weight);

                      // Navigate to HeightScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HeightScreen(
                            name: widget.name,
                            age: widget.age,
                            weight: weight,
                          ),
                        ),
                      );
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

  bool _validateWeight(String input) {
    // Validate if the input is a valid number greater than 0
    final weight = double.tryParse(input);
    return weight != null && weight > 0;
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
