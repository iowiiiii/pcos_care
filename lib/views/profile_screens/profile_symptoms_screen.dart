import 'package:flutter/material.dart';

class SymptomsScreen extends StatelessWidget {
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
        title: const Text('Symptoms'),
        backgroundColor: Color(0xFFE6E6FA),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16.0),
            height: 510.0,
            width: 399.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Color(0xFFE6E6FA), width: 2),
            ),
            child: ListView(
              children: <Widget>[
                Text(
                  'Display',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                _buildSymptomTile('Mood', Icons.remove_red_eye_outlined),
                _buildSymptomTile('Symptoms', Icons.remove_red_eye_outlined),
                _buildSymptomTile('Sex', Icons.remove_red_eye_outlined),
                _buildSymptomTile('Vaginal discharge', Icons.remove_red_eye_outlined),
                _buildSymptomTile('Oral contraceptives', Icons.remove_red_eye_outlined),
                _buildSymptomTile('Pregnancy test', Icons.remove_red_eye_outlined),
                _buildSymptomTile('Ovulation test', Icons.remove_red_eye_outlined),
                _buildSymptomTile('Note', Icons.remove_red_eye_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildSymptomTile(String title, dynamic leading) {
    return ListTile(
      leading: leading is String
          ? Image.asset(leading, width: 40, height: 40)
          : Icon(leading),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_upward),
            onPressed: () {
              // Functionality to move item up
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_downward),
            onPressed: () {
              // Functionality to move item down
            },
          ),
        ],
      ),
    );
  }
}
