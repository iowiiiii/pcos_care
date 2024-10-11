import 'package:flutter/material.dart';
import '../models/user_data_model.dart';
import '../api/bmi_api.dart';
import '../models/recommendations_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SelfCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Fetch user data (simulated)
    final userData = UserData.fetchData();

    // Get BMI Status (simulated)
    final bmiStatus = BMIStatus.getBMIStatus(userData.bmi);

    // Generate recommendations based on symptoms
    final symptomRecommendations = _generateSymptomRecommendations(userData.symptom);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text('PCOS CARE', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recommendations',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            buildRecommendationCard(
              title: 'BMI',
              status: bmiStatus['status'],
              statusColor: _getStatusColor(bmiStatus['statusColor']),
              description: bmiStatus['description'],
              recommendations: [
                RecommendationItem(
                  title: "A Dietitian's Guide to Healthy Living",
                  author: 'Alicia Pacheco, RD',
                  buttonLabel: 'Read article',
                  link: 'https://pcosnutritionistalyssa.com/7-day-pcos-diet-plan/', // Replace with actual link
                ),
                RecommendationItem(
                  title: 'Best PCOS Exercises',
                  author: 'Bridie Wilkins',
                  buttonLabel: 'Read article',
                  link: 'https://www.womenshealthmag.com/uk/fitness/workouts/a40036309/exercise-for-pcos/', // Replace with actual link
                ),
              ],
            ),
            SizedBox(height: 16),
            buildRecommendationCard(
              title: 'Symptoms',
              status: 'Alert',
              statusColor: Colors.orange,
              description: 'Based on your reported symptom: ${userData.symptom}, here are some recommendations:',
              recommendations: symptomRecommendations,
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Self-Care'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Helper method to get color from status
  Color _getStatusColor(String statusColor) {
    switch (statusColor) {
      case 'green':
        return Colors.green;
      case 'orange':
        return Colors.orange;
      case 'red':
        return Colors.red;
      default:
        return Colors.yellow;
    }
  }

  // Generate symptom-based recommendations
  List<RecommendationItem> _generateSymptomRecommendations(String symptom) {
    if (symptom == 'Headache') {
      return [
        RecommendationItem(title: 'Get enough rest and sleep'),
        RecommendationItem(title: 'Stay well hydrated with water'),
        RecommendationItem(title: 'Seek medical care'),
      ];
    } else if (symptom == 'Fatigue') {
      return [
        RecommendationItem(title: 'Increase iron intake in your diet'),
        RecommendationItem(title: 'Exercise regularly'),
      ];
    } else {
      return [
        RecommendationItem(title: 'Consult a healthcare professional'),
      ];
    }
  }

  // The recommendation card widget
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

  // The recommendation item widget
  Widget buildRecommendationItem(RecommendationItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: item.buttonLabel == null
          ? Row(
        children: [
          Icon(Icons.circle, size: 8, color: Colors.teal),
          SizedBox(width: 8),
          Expanded(child: Text(item.title)),
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
            onPressed: () async {
              final url = item.link!;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
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
