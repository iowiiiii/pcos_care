import 'package:flutter/material.dart';
import 'profile_screens/profile_screen.dart';
import 'calendar_screen.dart';
import 'selfcare_screen.dart';

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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              // Calendar Widget
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'September',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(7, (index) {
                        // List of day names
                        final days = ['Sun', 'Mon', 'Tues', 'Wed', 'Thu', 'Fri', 'Sat'];

                        // Start date (adjust as needed)
                        int startDate = 29;
                        // Calculate the date for each index
                        int date = (startDate + index) % 31; // Assuming 31 days in the month
                        if (date == 0) date = 1; // Adjust if the result is 0 (to show 1 instead)

                        return Column(
                          children: [
                            Text(days[index]), // Day names
                            CircleAvatar(
                              radius: 20,
                              child: Text('$date'), // Display calculated date
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
                      onPressed: () {},
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
                        Text('52 KG', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column( // Wrap this Column for the edit text and BMI text
                          children: [
                            GestureDetector( // Use GestureDetector to make the text clickable
                              onTap: () {
                                // Add your edit functionality here
                              },
                              child: Text(
                                'Edit', // The clickable edit text
                                style: TextStyle(fontSize: 10, color: Colors.grey), // Style it as you prefer
                              ),
                            ),
                            Text('BMI: 19.9', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Text('NORMAL', style: TextStyle(fontSize: 18, color: Colors.green)),
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
                padding: EdgeInsets.all(16.0), // Optional: Add padding to the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                  children: [
                    Text(
                      'Menstrual Cycle Phases',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10), // Optional: Add some space between the text and grid
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
                        // Create a list of menstrual phases
                        List<String> phases = [
                          'Menstrual Phase',
                          'Follicular Phase',
                          'Ovulation Phase',
                          'Luteal Phase',
                        ];

                        return Container(
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
                          child: Center(
                            child: Text(
                              phases[index], // Display each phase based on the index
                              textAlign: TextAlign.center,
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
}
