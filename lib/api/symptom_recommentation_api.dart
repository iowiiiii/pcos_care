import '../models/recommendations_model.dart';
import '../models/user_data_model.dart';

class SymptomRecommendationAPI {
  static Future<List<RecommendationItem>> fetchRecommendations({
    required List<String> symptoms,
    required UserData userData,
  }) async {
    await Future.delayed(Duration(seconds: 2));

    List<RecommendationItem> recommendations = [];

    for (String symptom in symptoms) {
      switch (symptom) {
        case 'Headache':
          recommendations.addAll([
            RecommendationItem(
              title: 'Get enough rest and sleep',
              author: 'Dr. John Doe',
              buttonLabel: 'Learn More',
              link: 'https://example.com/headache-care',
            ),
            RecommendationItem(
              title: 'Stay hydrated with water',
            ),
            if (userData.bmi > 25)
              RecommendationItem(
                title: 'Monitor blood pressure if headaches persist',
              ),
            RecommendationItem(
              title: 'Seek medical care if severe',
              buttonLabel: 'Find Doctor',
              link: 'https://example.com/find-doctor',
            ),
          ]);
          break;
        case 'Fatigue':
          recommendations.addAll([
            RecommendationItem(
              title: 'Increase iron intake in your diet',
            ),
            RecommendationItem(
              title: 'Exercise regularly',
            ),
          ]);
          break;
        case 'Acne':
          recommendations.addAll([
            RecommendationItem(
              title: 'Clean your skin with a gentle cleanser',
              author: 'Dermatologist Jane Smith',
              link: 'https://example.com/acne-care',
            ),
            RecommendationItem(
              title: 'Avoid touching your face',
            ),
            RecommendationItem(
              title: 'Consult a dermatologist',
              buttonLabel: 'Find Dermatologist',
              link: 'https://example.com/dermatologist',
            ),
          ]);
          break;
        default:
          recommendations.addAll([
            RecommendationItem(
              title: 'Consult a healthcare professional for more guidance',
            ),
          ]);
      }
    }

    return recommendations;
  }
}
