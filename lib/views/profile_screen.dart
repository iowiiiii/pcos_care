import 'package:flutter/material.dart';
import 'profile_screens/profile_goal_screen.dart';
import 'profile_screens/profile_cycle_screen.dart';
import 'profile_screens/profile_yob_screen.dart';
import 'profile_screens/profile_symptoms_screen.dart';
import 'profile_screens/profile_notification_screen.dart';
import 'calendar_screen.dart';
import 'selfcare_screen.dart';
import 'home_screen.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Set initial index for Profile tab

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SelfCareScreen()),
        );
        break;
      case 3:
      // Do nothing; already on ProfileScreen
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
          //if may gustong lagay dito
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildProfileItem(context, 'Goal', GoalScreen()),  // Navigate to GoalScreen
                _buildProfileItem(context, 'Cycle', CycleScreen()),  // Navigate to CycleScreen
                _buildProfileItem(context, 'Year of birth', YearBirthScreen()),
                _buildProfileItem(context, 'Symptoms order', SymptomsScreen()),
                _buildProfileItem(context, 'Notifications', NotificationScreen()),
              ],
            ),
          ),
        ),
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

  Widget _buildProfileItem(BuildContext context, String title, Widget destination) {
    return ListTile(
      leading: const Icon(Icons.star_border),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
    );
  }
}
