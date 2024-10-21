import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controller/csv_manager.dart';
import '../../controller/step_progress_indicator.dart';
import 'finish_setup_screen.dart';
import '../../models/user_data_model.dart';

class LastPeriodScreen extends StatefulWidget {
  final String name;

  LastPeriodScreen({required this.name});

  @override
  _LastPeriodScreenState createState() => _LastPeriodScreenState();
}

class _LastPeriodScreenState extends State<LastPeriodScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final CSVManager csvManager = CSVManager();
  bool _isLoading = false;

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
        backgroundColor: Color.fromRGBO(230, 230, 250, 1),
      ),
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              StepProgressIndicator(currentStep: 7),
              SizedBox(height: 30),
              Text(
                'When was your last period?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TableCalendar(
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.now(),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                    if (_selectedDay == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a date.'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      // Create a new UserData instance with placeholder values
                      UserData userData = UserData(
                        name: widget.name,
                        weight: 0, // Placeholder value
                        height: 0, // Placeholder value
                        bmi: 0, // Placeholder value
                        classification: '', // Placeholder value
                        lastPeriodDate: _selectedDay!, // User selected date
                        age: 0, // Placeholder value
                        cycleLength: 28, // Example placeholder for cycle length
                        weightGain: false,
                        hairGrowth: false,
                        skinDarkening: false,
                        hairLoss: false,
                        pimples: false,
                        fastFood: false,
                        regularExercise: true,
                      );

                      // Assuming csvManager has a method to save user data
                      await csvManager.addToCSV([
                        widget.name,
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        _selectedDay!.toIso8601String(),
                      ]);

                      // Navigate to FinishSetupScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinishSetupScreen(
                            name: widget.name,
                            userData: userData,
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('An error occurred. Please try again.'),
                        ),
                      );
                    } finally {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 111, 97, 1),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
