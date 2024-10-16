import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'edit_period_days.dart';
import 'profile_screen.dart';
import 'calendar_screen.dart';
import 'selfcare_screen.dart';
import 'menstrual_cycle_screen.dart';
import '../models/user_data_model.dart';
import '../models/recommendations_model.dart';

class HomeScreen extends StatefulWidget {
  final UserData userData;
  final List<String> symptoms;
  final List<RecommendationItem> recommendations;

  const HomeScreen({
    Key? key,
    required this.userData,
    required this.symptoms,
    required this.recommendations,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _weight = '52 KG'; // Default weight
  double _height = 1.65; // Default height in meters
  double _bmi = 19.9; // Default BMI value
  String _classification = 'NORMAL'; // Default classification
  UserData? userData; // User data variable to hold the data loaded from CSV

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/user_data.csv';
    final input = File(path).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter())
        .toList();

    if (fields.isNotEmpty) {
      setState(() {
        _weight = '${fields[0][0]} KG';
        _height = fields[0][1];
        _bmi = fields[0][2];
        _classification = fields[0][3];
        userData = UserData.fromCsv(fields[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentDayIndex = now.weekday % 7;
    DateTime startOfWeek = now.subtract(Duration(days: currentDayIndex));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'PCOS CARE',
          style: TextStyle(color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFE6E6FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat.MMMM().format(now),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        DateTime date = startOfWeek.add(Duration(days: index));
                        String dayName = DateFormat.E().format(date);
                        bool isToday = index == currentDayIndex;

                        return Column(
                          children: [
                            Text(dayName),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: isToday ? Colors.red : Colors.transparent,
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(
                                  color: isToday ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Cycle Day
              Container(
                width: 382,
                height: 187,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE2BCBB),
                      Color(0xFFFE7F8D),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Cycle:', style: TextStyle(fontSize: 18, color: Colors.white)),
                    Text('Day 25', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xFFFF6F61), // Text color
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditPeriodDays()));
                      },
                      child: Text('Edit Period Dates'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // BMI Info from CSV Data
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('BMI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(_weight, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red)),
                        Text('Height: $_height m', style: TextStyle(fontSize: 18)),
                        Text('Classification: $_classification', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBmiEditDialog();
                          },
                          child: Text(
                            'Edit', 
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Menstrual Cycle Phases
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menstrual Cycle Phases',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: 4, 
                        itemBuilder: (context, index) {
                          List<String> phases = [
                            'Menstrual Phase',
                            'Follicular Phase',
                            'Ovulation Phase',
                            'Luteal Phase',
                          ];

                          List<String> images = [
                            'assets/icons/menstrual.png',
                            'assets/icons/follicular.png',
                            'assets/icons/ovulation.png',
                            'assets/icons/luteal.png',
                          ];

                          return GestureDetector(
                            onTap: () {
                              _navigateToPhase(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE2BCBB),
                                    Color(0xFFFE7F8D),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    images[index],
                                    height: 50,
                                    width: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Text(phases[index],
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Self-Care'),
        ],
        selectedItemColor: Color(0xFFFF6F61),
        unselectedItemColor: Colors.grey,
      onTap: (index) {
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CalendarScreen(
                  userData: userData!,
                ),
              ),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SelfCareScreen(
                  userData: userData!,
                  symptoms: [],
                  recommendations: [],
                ),
              ),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                  userData: userData!,
                  symptoms: [],
                  recommendations: [],
                ),
              ),
            );
            break;
        }
        },
      ),
    );
  }

  // BMI Edit Dialog
  void _showBmiEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String weight = _weight.split(' ')[0];
        return AlertDialog(
          title: Text('Edit Weight'),
          content: TextField(
            onChanged: (value) {
              weight = value;
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter your weight in KG'),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  _weight = '$weight KG';
                  _bmi = _calculateBMI(double.parse(weight), _height);
                  _classification = _classifyBMI(_bmi);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // BMI Calculation
  double _calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  // BMI Classification Logic
  String _classifyBMI(double bmi) {
    if (bmi < 18.5) return 'UNDERWEIGHT';
    if (bmi >= 18.5 && bmi < 24.9) return 'NORMAL';
    if (bmi >= 25 && bmi < 29.9) return 'OVERWEIGHT';
    return 'OBESE';
  }

  void _navigateToPhase(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MenstrualCycleSlider(phaseIndex: index)),
    );
  }
}
