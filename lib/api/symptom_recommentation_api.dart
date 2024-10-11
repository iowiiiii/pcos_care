import '../models/recommendations_model.dart';

class SymptomRecommendationAPI {
  // Simulated API function to fetch recommendations based on symptoms
  static Future<List<RecommendationItem>> fetchRecommendations(List<String> symptoms) async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    List<RecommendationItem> recommendations = [];

    // Simulated recommendation logic
    for (String symptom in symptoms) {
      switch (symptom) {
        case 'Headache':
          recommendations.addAll([
            RecommendationItem(title: 'Get enough rest and sleep'),
            RecommendationItem(title: 'Stay well hydrated with water'),
            RecommendationItem(title: 'Seek medical care'),
          ]);
          break;
        case 'Fatigue':
          recommendations.addAll([
            RecommendationItem(title: 'Increase iron intake in your diet'),
            RecommendationItem(title: 'Exercise regularly'),
          ]);
          break;
        case 'Acne':
          recommendations.addAll([
            RecommendationItem(title: 'Clean your skin with a gentle cleanser'),
            RecommendationItem(title: 'Avoid touching your face'),
            RecommendationItem(title: 'Consult a dermatologist'),
          ]);
          break;
        case 'Cramps':
          recommendations.addAll([
            RecommendationItem(title: 'Take a warm bath or use a heating pad'),
            RecommendationItem(title: 'Try yoga or stretching exercises'),
          ]);
          break;
      // Add more cases for other symptoms
        case 'Breast sensitivity':
          recommendations.addAll([
            RecommendationItem(title: 'Wear a supportive bra'),
            RecommendationItem(title: 'Reduce caffeine intake'),
          ]);
          break;
        case 'Vaginal itching':
          recommendations.addAll([
            RecommendationItem(title: 'Avoid scented products'),
            RecommendationItem(title: 'Consult your doctor for anti-fungal medication'),
          ]);
          break;
        default:
          recommendations.addAll([
            RecommendationItem(title: 'Consult a healthcare professional for more guidance'),
          ]);
      }
    }

    return recommendations;
  }
}
