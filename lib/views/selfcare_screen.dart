import 'package:flutter/material.dart';
import 'profile_screens/profile_screen.dart';
import 'calendar_screen.dart';
import 'home_screen.dart';

class SelfCareScreen extends StatefulWidget {
  @override
  _SelfCareScreen createState() => _SelfCareScreen();
}

class _SelfCareScreen extends State<SelfCareScreen> {
  int _selectedIndex = 2; // Set initial index for Self-Care tab

  void _onItemTapped(int index) {
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
      // Do nothing; already on SelfCareScreen
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PCOS CARE'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo.png'), // Replace with your logo
        ),
        actions: [
          //empty right top bar
        ],
      ),
      body: Column( // Change here to use Column
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recommendations',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Add more widgets here if needed
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF262626),
        selectedItemColor: const Color(0xFFD4A5A5),  // Color for the selected icon
        unselectedItemColor: const Color(0xFFACACBA),  // Color for unselected icons
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
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
      ),
    );
  }
}
