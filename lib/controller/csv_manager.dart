import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user_data_model.dart';

class CSVManager {
  File? csvFile;
  List<List<dynamic>> csvData = [];

  //initialize CSV, add headers if file doesn't exist
  Future<void> initializeCSV(String userName) async {
    final path = await _getCsvFilePath(); // _getCsvFilePath method
    csvFile = File(path);

    //check if file exists
    if (!(await csvFile!.exists())) {
      csvData.add(['Name', 'Birthday', 'Age', 'Weight', 'Height', 'BMI', 'Period Duration', 'Cycle Length', 'Last Period']);
      csvData.add([userName, '', '', '', '', '', '', '', '']); //add user row with empty fields
      await writeCSV();
    } else {
      String contents = await csvFile!.readAsString();
      csvData = const CsvToListConverter().convert(contents);
    }
  }

  //get the file path for the CSV file
  Future<String> _getCsvFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/userdata.csv'; // File name and path
  }

  // add new row for each new entry
  Future<void> addToCSV(List<dynamic> newData) async {
    csvData.add(newData); // add new data as a new row
    await writeCSV();
  }

  // write CSV data to file
  Future<void> writeCSV() async {
    if (csvFile != null) {
      String csvString = const ListToCsvConverter().convert(csvData);
      await csvFile!.writeAsString(csvString);
    }
  }

  double calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }

  int calculateAge(DateTime birthday) {
    DateTime now = DateTime.now();
    int age = now.year - birthday.year;
    if (now.month < birthday.month || (now.month == birthday.month && now.day < birthday.day)) {
      age--;
    }
    return age;
  }

  Future<void> addBirthdayAndAge(DateTime birthday) async {
    int age = calculateAge(birthday);
    await addToCSV([csvData[1][0], birthday.toIso8601String(), age, '', '', '', '', '', '']);
  }

  Future<void> addWeightToCSV(String userName, double weight) async {
    for (int i = 1; i < csvData.length; i++) { // Skip header
      if (csvData[i][0] == userName) {
        csvData[i][3] = weight; 
        break;
      }
    }
    await writeCSV();
  }

  Future<void> addHeightAndBmiToCSV(String name, int age, double height, double bmi) async {
    for (int i = 1; i < csvData.length; i++) { // Skip header
      if (csvData[i][0] == name) {
        csvData[i][4] = height; 
        csvData[i][5] = bmi; 
        break;
      }
    }
    await writeCSV();
  }

  //retrieve user data from the CSV file
  Future<UserData?> getUserData(String userName) async {
    //load existing data if not already loaded
    if (csvData.isEmpty) {
      String contents = await csvFile!.readAsString();
      csvData = const CsvToListConverter().convert(contents);
    }

    for (int i = 1; i < csvData.length; i++) { // Skip header
      if (csvData[i][0] == userName) {
        
        DateTime? birthday;
        if (csvData[i][1].isNotEmpty) {
          birthday = DateTime.tryParse(csvData[i][1]);
        }

        int age = csvData[i][2] != '' ? int.tryParse(csvData[i][2]) ?? 0 : 0;
        double weight = csvData[i][3] != '' ? double.tryParse(csvData[i][3]) ?? 0.0 : 0.0;
        double height = csvData[i][4] != '' ? double.tryParse(csvData[i][4]) ?? 0.0 : 0.0;
        double bmi = csvData[i][5] != '' ? double.tryParse(csvData[i][5]) ?? 0.0 : 0.0;

        DateTime? lastPeriodDate;
        if (csvData[i][8].isNotEmpty) {
          lastPeriodDate = DateTime.tryParse(csvData[i][8]);
        }

//any of these can be adjusted based on updates on other screens
        return UserData(
          name: csvData[i][0],
          birthday: birthday,
          age: age,
          weight: weight,
          height: height,
          bmi: bmi,
          classification: '', 
          lastPeriodDate: lastPeriodDate,
          cycleLength: null,
          weightGain: null, 
          hairGrowth: null, 
          skinDarkening: null, 
          hairLoss: null, 
          pimples: null, 
          fastFood: null, 
          regularExercise: null, 
        );
      }
    }

    return null; 
  }
}
