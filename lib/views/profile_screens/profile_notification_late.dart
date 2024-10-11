import 'package:flutter/material.dart';

class ProfileNotificationLate extends StatefulWidget {
  @override
  _ProfileNotificationLate createState() => _ProfileNotificationLate();
}

class _ProfileNotificationLate extends State<ProfileNotificationLate> {
  bool _isPeriodOn = false; // Track the state of the switch

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Late Period Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the start
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and switch
              children: [
                const Text(
                  'Enable Late Period Notifications',
                  style: TextStyle(fontSize: 18),
                ),
                Switch(
                  value: _isPeriodOn, // Switch reflects the current state
                  onChanged: (value) {
                    setState(() {
                      _isPeriodOn = value; // Update switch state
                    });
                  },
                ),
              ],
            ),
            if (_isPeriodOn) _buildReminderFields(), // Show reminder fields when enabled
          ],
        ),
      ),
    );
  }

  Widget _buildReminderFields() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          const Text('Reminder Time:', style: TextStyle(fontSize: 16)),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                items: <String>['AM', 'PM']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {},
                hint: const Text('AM/PM'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text('Reminder Text:', style: TextStyle(fontSize: 16)),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Implement save functionality here
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
