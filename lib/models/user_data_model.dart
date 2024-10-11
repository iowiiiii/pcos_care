class UserData {
  double bmi;
  String symptom;

  UserData({required this.bmi, required this.symptom});

  // Example method to simulate fetching user data
  static UserData fetchData() {
    // Hardcoded values to simulate fetched data
    return UserData(bmi: 22.5, symptom: 'Headache');
  }
}
