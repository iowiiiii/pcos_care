import 'package:flutter/material.dart';
import 'profile_notification_period.dart';  // Import your notification screens
import 'profile_notification_late.dart';
import 'profile_notification_ovulation.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notifications'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 230.0, // Fixed height
          width: 399.0, // Fixed width
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Color(0xFFE6E6FA), width: 2),
          ),
          child: ListView(
            children: <Widget>[
              // Custom layout for ListTile with navigation
              _buildCustomTile(
                context,
                Icons.notifications,
                'Period',
                'Off',
                ProfileNotificationPeriod(),
              ),
              _buildCustomTile(
                context,
                Icons.notifications,
                'Late period',
                'Off',
                ProfileNotificationLate(),
              ),
              _buildCustomTile(
                context,
                Icons.notifications,
                'Ovulation',
                'Off',
                ProfileNotificationOvulation(),
              ),
              // Add more ListTile items as needed
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCustomTile(BuildContext context, IconData icon, String title, String subtitle, Widget destination) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding notification screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0), // Space between tiles
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns icon and text to the start
          children: [
            Icon(icon),
            SizedBox(width: 16), // Space between icon and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.grey, // Grey color for the subtitle
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
