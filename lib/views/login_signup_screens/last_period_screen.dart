import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controller/csv_manager.dart';
import '../../controller/step_progress_indicator.dart';
import 'finish_setup_screen.dart';

class LastPeriodScreen extends StatefulWidget {
  final String name;

  LastPeriodScreen({required this.name});

  @override
  _LastPeriodScreenState createState() => _LastPeriodScreenState();
}

class _LastPeriodScreenState extends State<LastPeriodScreen> {
  DateTime _focusedDay = DateTime.now();
  List<DateTime> _selectedDays = [];
  final CSVManager csvManager = CSVManager();

  get userData => null;

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
              SizedBox(height: 30),
              Text(
                'When was your last period?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Calendar Widget
              TableCalendar(
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) {
                  return _selectedDays.contains(day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    if (_selectedDays.contains(selectedDay)) {
                      _selectedDays.remove(selectedDay);
                    } else {
                      _selectedDays.add(selectedDay);
                    }
                    _focusedDay = focusedDay; 
                  });
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    List<String> periodDates = _selectedDays.map((day) => day.toIso8601String()).toList();
                    
                    await csvManager.addToCSV([widget.name, '', '', '', '', '', '', '', periodDates.join(', ')]);
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FinishSetupScreen(name: widget.name, userData: userData,),
                      ),
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
      ),
    );
  }
}
