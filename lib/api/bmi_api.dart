class BMIStatus {
  static Map<String, dynamic> getBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return {
        'status': 'Underweight',
        'statusColor': 'yellow',
        'description': 'You are underweight. Consider a balanced diet.',
      };
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return {
        'status': 'Normal',
        'statusColor': 'green',
        'description': 'You are maintaining a healthy BMI. Keep it up!',
      };
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return {
        'status': 'Overweight',
        'statusColor': 'orange',
        'description': 'You are overweight. Exercise and diet may help.',
      };
    } else {
      return {
        'status': 'Obese',
        'statusColor': 'red',
        'description': 'You are obese. Consult a healthcare professional.',
      };
    }
  }
}
