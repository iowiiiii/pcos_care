import '../models/recommendations_model.dart';
import 'package:flutter/material.dart';
import 'profile_screens/profile_screen.dart';
import 'home_screen.dart';
import 'calendar_screen.dart';

class SelfCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('PCOS CARE', style: TextStyle(color: Colors.black)),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.error, color: Colors.red), // Temporary placeholder for logo
        ),
      ),
      body: SingleChildScrollView( // Enable scrolling for content
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recommendations',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            buildRecommendationCard(
              title: 'BMI',
              status: 'Normal',
              statusColor: Colors.green,
              description:
              'You are dashing with your current physique! Here are some recommendations to maintain your BMI:',
              recommendations: [
                RecommendationItem(
                  title: "A Dietitian's 7-Day PCOS Diet Plan",
                  author: 'Alicia Pacheco, RD',
                  buttonLabel: 'Read article',
                ),
                RecommendationItem(
                  title: 'Exercise for PCOS: how it can help and types to avoid',
                  author: 'Bridie Wilkins',
                  buttonLabel: 'Read article',
                ),
              ],
            ),
            SizedBox(height: 16),
            buildRecommendationCard(
              title: 'Symptoms',
              status: 'Alert',
              statusColor: Colors.orange,
              description:
              'You seem to have a persistent headache for 3 days. Here are some recommendations:',
              recommendations: [
                RecommendationItem(
                  title: 'Get enough rest and sleep',
                ),
                RecommendationItem(
                  title: 'Stay well hydrated with water',
                ),
                RecommendationItem(
                  title: 'Seek medical care',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF262626),
        selectedItemColor: Color(0xFFD4A5A5),
        unselectedItemColor: Color(0xFFACACBA),
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Self-care tab
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
            // Stay on SelfCareScreen
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

  Widget buildRecommendationCard({
    required String title,
    required String status,
    required Color statusColor,
    required String description,
    required List<RecommendationItem> recommendations,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 16),
            Column(
              children: recommendations.map((rec) => buildRecommendationItem(rec)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRecommendationItem(RecommendationItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: item.buttonLabel == null
          ? Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.teal),
          SizedBox(width: 8),
          Expanded(
            child: Text(item.title),
          ),
        ],
      )
          : Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text("By: ${item.author}"),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(item.buttonLabel!),
          ),
        ],
      ),
    );
  }
}