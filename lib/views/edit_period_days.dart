import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EditPeriodDays extends StatefulWidget {
  @override
  _EditPeriodDaysState createState() => _EditPeriodDaysState();
}

class _EditPeriodDaysState extends State<EditPeriodDays> {
  DateTime _focusedDay = DateTime.now();
  List<DateTime> _markedDays = [DateTime.now()]; // Start with the current day marked

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('Edit Period', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => _markedDays.contains(day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;

                // Toggle marking/unmarking the selected day
                if (_markedDays.contains(selectedDay)) {
                  _markedDays.remove(selectedDay);
                } else {
                  _markedDays.add(selectedDay);
                }
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              markersMaxCount: 1,
              outsideDaysVisible: true,
            ),
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Logic to save the marked days
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }
}