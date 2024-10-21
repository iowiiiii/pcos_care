import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../controller/step_progress_indicator.dart';
import '../../controller/csv_manager.dart';
import 'weight_screen.dart';

class BirthdayScreen extends StatefulWidget {
  final String name;

  BirthdayScreen({required this.name});

  @override
  _BirthdayScreenState createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  int selectedMonth = 1;
  int selectedDay = 1;
  int selectedYear = 2000;

  List<int> days = List.generate(31, (index) => index + 1);
  List<int> years = List.generate(100, (index) => DateTime.now().year - index);
  List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  CSVManager csvManager = CSVManager();

  @override
  void initState() {
    super.initState();
    csvManager.initializeCSV(widget.name);
  }

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
        title: Text('Setup Your Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(230, 230, 250, 100),
      ),
      body: Material(
        color: Color.fromRGBO(230, 230, 250, 100),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              StepProgressIndicator(currentStep: 2),
              SizedBox(height: 20),
              Text(
                'When is your birthday?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Month Picker
                  Expanded(
                    child: Column(
                      children: [
                        Text('MM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 150, // Adjust height for better visibility
                          child: CupertinoPicker(
                            itemExtent: 50,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedMonth = index + 1; // Months are 1-indexed
                              });
                            },
                            children: List.generate(months.length, (index) {
                              return Center(child: Text(months[index])); // Display month names
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Day Picker
                  Expanded(
                    child: Column(
                      children: [
                        Text('DD', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 150, // Adjust height for better visibility
                          child: CupertinoPicker(
                            itemExtent: 50,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedDay = index + 1; // Days are 1-indexed
                              });
                            },
                            children: List.generate(days.length, (index) {
                              return Center(child: Text('${days[index]}')); // Display day numbers
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Year Picker
                  Expanded(
                    child: Column(
                      children: [
                        Text('YYYY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 150, // Adjust height for better visibility
                          child: CupertinoPicker(
                            itemExtent: 50,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                selectedYear = years[index]; // Select year
                              });
                            },
                            children: List.generate(years.length, (index) {
                              return Center(child: Text('${years[index]}')); // Display year
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    DateTime birthday = DateTime(selectedYear, selectedMonth, selectedDay);
                    int age = csvManager.calculateAge(birthday);
                    await csvManager.addBirthdayAndAge(birthday);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WeightScreen(name: widget.name, age: age)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 111, 97, 1),
                  ),
                  child: Text('Next', style: TextStyle(color: Colors.white70)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
