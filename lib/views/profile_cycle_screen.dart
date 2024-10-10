import 'package:flutter/material.dart';

class CycleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Cycle'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Cycle length'),
                      subtitle: Text('28 days'),
                      onTap: () {
                        _showCycleLengthPicker(context);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Periods length'),
                      subtitle: Text('5 days'),
                      onTap: () {
                        _showPeriodsLengthPicker(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCycleLengthPicker(BuildContext context) {
    int selectedCycleLength = 28; // Default value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Cycle Length')),
          content: Container(
            height: 150, // Set a fixed height
            child: Column(
              children: [
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    physics: FixedExtentScrollPhysics(),
                    diameterRatio: 2.0,
                    perspective: 0.005,
                    overAndUnderCenterOpacity: 0.5,
                    onSelectedItemChanged: (index) {
                      selectedCycleLength = index + 20; // Adjust to your range (e.g., 20-45)
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            '${index + 20}', // Numbers from 20 to 45 (or your preferred range)
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                      childCount: 26, // Number of cycle lengths (e.g., from 20 to 45)
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog without action
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Update cycle length here
                        Navigator.pop(context);
                        // You can store or use `selectedCycleLength` here
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPeriodsLengthPicker(BuildContext context) {
    int selectedPeriodLength = 5; // Default value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Periods Length')),
          content: Container(
            height: 150, // Set a fixed height
            child: Column(
              children: [
                Expanded(
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    physics: FixedExtentScrollPhysics(),
                    diameterRatio: 2.0,
                    perspective: 0.005,
                    overAndUnderCenterOpacity: 0.5,
                    onSelectedItemChanged: (index) {
                      selectedPeriodLength = index + 1; // Adjust to your range (e.g., 1-10)
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            '${index + 1}', // Numbers from 1 to 10 (or your preferred range)
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                      childCount: 10, // Number of period lengths (e.g., from 1 to 10)
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog without action
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Update periods length here
                        Navigator.pop(context);
                        // You can store or use `selectedPeriodLength` here
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
