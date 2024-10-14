import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For handling dates
import 'package:pcos_care/views/edit_period_days.dart';
import 'profile_screen.dart';
import 'calendar_screen.dart';
import 'selfcare_screen.dart';
import 'menstrual_cycle_screen.dart';

void main() {
  runApp(HomeScreenRun());
}

class HomeScreenRun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _weight = '52 KG'; // Default weight
  double _height = 1.65; // Default height in meters
  double _bmi = 19.9; // Default BMI value
  String _classification = 'NORMAL'; // Default classification

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int currentDayIndex = now.weekday % 7; // 0: Sunday, 6: Saturday
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
          child: Image.asset('assets/logo.png'), // Replace with logo
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
              // Calendar Widget (Week Days)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat.MMMM().format(now), // Display the current month
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        DateTime date = startOfWeek.add(Duration(days: index));
                        String dayName = DateFormat.E().format(date); // Day name
                        bool isToday = index == currentDayIndex;

                        return Column(
                          children: [
                            Text(dayName), // Display day name (Sun, Mon, etc.)
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
                  //Color Gradient
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

              // BMI Info
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
                            'Edit', // Clickable edit button
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ),
                        Text('BMI: ${_bmi.toStringAsFixed(1)}', style: TextStyle(fontSize: 18)),
                        Text(_classification, style: TextStyle(fontSize: 18, color: Colors.green)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Menstrual Cycle Phases as Picture Buttons
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
                        crossAxisCount: 2, // 2 items per row
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.5,
                      ),
                      itemCount: 4, // Now 4 items for a 2x2 grid
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
                            _navigateToPhase(index); // Call a function for navigation
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12), // Match the container's radius
                              child: Center(
                                child: Image.asset(
                                  images[index], // Display the image for the phase
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF262626),
        selectedItemColor: Color(0xFFD4A5A5),
        unselectedItemColor: Color(0xFFACACBA),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
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
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CalendarScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SelfCareScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }

  // Function to show BMI edit dialog
  void _showBmiEditDialog() {
    TextEditingController weightController = TextEditingController(text: _weight.split(' ')[0]);
    TextEditingController heightController = TextEditingController(text: _height.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit BMI'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Weight (KG)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Height (M)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _weight = '${weightController.text} KG';
                  _height = double.parse(heightController.text);
                  _bmi = _calculateBmi(double.parse(weightController.text), _height);
                  _classification = _getBmiClassification(_bmi);
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Function to calculate BMI
  double _calculateBmi(double weight, double height) {
    return weight / (height * height);
  }

  // Function to get BMI classification
  String _getBmiClassification(double bmi) {
    if (bmi < 18.5) return 'UNDERWEIGHT';
    if (bmi >= 18.5 && bmi < 24.9) return 'NORMAL';
    if (bmi >= 25 && bmi < 29.9) return 'OVERWEIGHT';
    return 'OBESE';
  }

  // Navigate to respective phase screen
  void _navigateToPhase(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenstrualCycleSlider(initialPage: index), // Pass index
      ),
    );
  }
}


