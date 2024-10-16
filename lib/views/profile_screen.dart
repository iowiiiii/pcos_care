import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'profile_screens/profile_goal_screen.dart';
import 'profile_screens/profile_cycle_screen.dart';
import 'profile_screens/profile_yob_screen.dart';
import 'profile_screens/profile_symptoms_screen.dart';
import 'profile_screens/profile_notification_screen.dart';
import 'calendar_screen.dart';
import 'selfcare_screen.dart';
import 'home_screen.dart';
import '../models/user_data_model.dart';

class ProfileScreen extends StatefulWidget {
  final UserData userData;

  const ProfileScreen({Key? key, required this.userData, required List symptoms, required List recommendations}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen(
                  userData: widget.userData,
                  symptoms: widget.userData.symptoms,
                  recommendations: [],
                ),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CalendarScreen(
                  userData: widget.userData,
                ),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                SelfCareScreen(
                  userData: widget.userData,
                  symptoms: widget.userData.symptoms,
                  recommendations: [],
                ),
          ),
        );
        break;
      case 3:
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
          child: Image.asset('assets/logo.png'), 
        ),
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
                _buildProfileItem(
                    context, 'Goal', GoalScreen(), widget.userData.goal),
                _buildProfileItem(
                    context, 'Cycle', CycleScreen(), widget.userData.cycle),
                _buildProfileItem(context, 'Year of birth', YearBirthScreen(),
                    widget.userData.yearOfBirth.toString()),
                _buildProfileItem(context, 'Symptoms order', SymptomsScreen(),
                    widget.userData.symptoms.join(", ")),
                _buildProfileItem(
                    context, 'Notifications', NotificationScreen(),
                    widget.userData.notifications ? "On" : "Off"),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Self-Care'),
        ],
        selectedItemColor: Color(0xFFFF6F61),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, 
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, String title,
      Widget destination, String? data) {
    return ListTile(
      leading: const Icon(Icons.star_border),
      title: Text('$title: ${data ?? "Not set"}'), 
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
