import '../controller/csv_manager.dart';

class UserData {
  String name;
  double weight;
  double height;
  double bmi;
  String classification;
  DateTime? lastPeriodDate;
  int age;
  double? cycleLength;
  bool? weightGain;
  bool? hairGrowth;
  bool? skinDarkening;
  bool? hairLoss;
  bool? pimples;
  bool? fastFood;
  bool? regularExercise;
  DateTime? birthday;

  UserData({
    required this.name,
    required this.weight,
    required this.height,
    required this.bmi,
    required this.classification,
    this.lastPeriodDate,
    required this.age,
    this.cycleLength,
    this.weightGain,
    this.hairGrowth,
    this.skinDarkening,
    this.hairLoss,
    this.pimples,
    this.fastFood,
    this.regularExercise,
    this.birthday,
  });

  get symptoms => null;

  String? get goal => null;

  String? get cycle => null;

  get notifications => null;

  get yearOfBirth => null;

  double getWeight() => weight;
  double getHeight() => height;
  double getBmi() => bmi;
  String getClassification() => classification;
  DateTime? getLastPeriodDate() => lastPeriodDate;

  factory UserData.fromCsv(List<dynamic> fields) {
    return UserData(
      name: fields[0].toString(),
      weight: fields[1].toDouble(),
      height: fields[2].toDouble(),
      bmi: fields[3].toDouble(),
      classification: fields[4].toString(),
      lastPeriodDate: DateTime.parse(fields[5]),
      age: fields[6].toInt(),
      cycleLength: fields[7].toDouble(),
      weightGain: fields[8] == 'true',
      hairGrowth: fields[9] == 'true',
      skinDarkening: fields[10] == 'true',
      hairLoss: fields[11] == 'true',
      pimples: fields[12] == 'true',
      fastFood: fields[13] == 'true',
      regularExercise: fields[14] == 'true',
    );
  }

  static Future<UserData?> fetchData(String filePath) async {

    CSVManager csvManager = CSVManager();
    await csvManager.initializeCSV('');
    return await csvManager.getUserData(filePath);
  }
}
