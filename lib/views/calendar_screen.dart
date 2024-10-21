import 'package:flutter/material.dart';
import 'package:pcos_care/views/edit_period_days.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../controller/csv_manager.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'selfcare_screen.dart';
import '../models/user_data_model.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late UserData userData;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<String, String> optionsSelected = {
    "Menstrual Flow": "",
  };
  Map<String, List<String>> multiOptionsSelected = {
    "Symptoms": [],
  };

  bool _isScrollSheetVisible = true;
  CSVManager csvManager = CSVManager();
  
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    csvManager.initializeCSV('userName');
  }

  Future<void> saveDataToCSV() async {
    String menstrualFlow = optionsSelected["Menstrual Flow"] ?? "";
    List<String> symptoms = multiOptionsSelected["Symptoms"] ?? [];

    // Prepare the data to be saved
    List<String> newData = [
      DateFormat('yyyy-MM-dd').format(_selectedDay),  // Date
      menstrualFlow,                                  // Menstrual flow
      symptoms.join(', ')                             // Symptoms
    ];

    await csvManager.addToCSV(newData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('PCOS CARE', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 1, 1),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _isScrollSheetVisible = true;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.grey[600],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          if (_isScrollSheetVisible)
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 1,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(213, 219, 239, 1.0),
                        Color.fromRGBO(188, 198, 209, 1.0)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    _isScrollSheetVisible = false;
                                  });
                                },
                              ),
                              Text(
                                _selectedDay.isSameDate(DateTime.now())
                                    ? "Today, ${DateFormat('MMMM d').format(_selectedDay)}"
                                    : "${DateFormat('EEEE, MMMM d').format(_selectedDay)}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        buildOptionsSection("Menstrual Flow", ["Light", "Moderate", "Heavy"], isSingleSelection: true),
                        buildOptionsSection("Symptoms", [
                          "Acne", "Headache", "Backache", "Cramps", "Fatigue", "Nausea",
                          "Breast sensitivity", "Chills", "Left ovary pain", "Right ovary pain",
                          "Migraine", "Frequent urination", "Diarrhea", "Constipation",
                          "Vaginal itching", "Vaginal burning",
                        ], isSingleSelection: false),
                        ElevatedButton(
                          onPressed: saveDataToCSV,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(255, 111, 97, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text("SAVE DATA", style: TextStyle(color: Colors.white70)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF262626),
        selectedItemColor: Color(0xFFD4A5A5),
        unselectedItemColor: Color(0xFFACACBA),
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // Set the current index here
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Self-Care',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(userData: userData, symptoms: [], recommendations: [],)),
              );
              break;
            case 1:
            // Stay on CalendarScreen
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SelfCareScreen(userData: userData, symptoms: [], recommendations: [],)),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen(userData: userData, symptoms: [], recommendations: [],)),
              );
              break;
          }
        },
      ),
    );
  }

  Widget buildOptionsSection(String title, List<String> options, {required bool isSingleSelection}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: options.map((option) {
            bool isSelected = isSingleSelection
                ? optionsSelected[title] == option
                : multiOptionsSelected[title]?.contains(option) ?? false;
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSingleSelection) {
                    optionsSelected[title] = option;
                  } else {
                    if (multiOptionsSelected[title]?.contains(option) ?? false) {
                      multiOptionsSelected[title]?.remove(option);
                    } else {
                      multiOptionsSelected[title]?.add(option);
                    }
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blueGrey[200] : Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: isSelected ? Colors.blueGrey : Colors.blueGrey[300]!,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(color: isSelected ? Colors.black : Colors.grey[600]),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  bool isSameCalendarDate(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }
}
