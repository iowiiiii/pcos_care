import 'package:flutter/material.dart';

class YearBirthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Calculate the index for the year 2000 (as it corresponds to index 20 in a 1980-2024 range)
    final initialIndex = 2000 - 1980; // Index for the year 2000

    // Initialize the scroll controller with the initial index (for 2000)
    FixedExtentScrollController scrollController = FixedExtentScrollController(initialItem: initialIndex);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Year of Birth', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Select Your Year of Birth',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListWheelScrollView.useDelegate(
                controller: scrollController, // Use the controller to set the initial scroll position
                itemExtent: 50,
                physics: FixedExtentScrollPhysics(),
                diameterRatio: 2.0,
                perspective: 0.005,
                overAndUnderCenterOpacity: 0.5,
                onSelectedItemChanged: (index) {
                  // Handle selection logic here
                  int selectedYear = index + 1980; // Years range from 1980 to 2024
                  print('Selected year: $selectedYear');
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return Center(
                      child: Text(
                        '${index + 1980}', // Show years 1980 to 2024
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                  childCount: 45, // Number of years from 1980 to 2024
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cancel and close
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add action for 'OK' button, like saving the selected year
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
