import '../models/recommendations_model.dart';
import '../models/user_data_model.dart';

class SymptomRecommendationAPI {
  static Future<List<RecommendationItem>> fetchRecommendations({
    required List<String> symptoms,
    required UserData userData,
  }) async {
    await Future.delayed(Duration(seconds: 2));

    List<RecommendationItem> recommendations = [];

    //BMI-based recommendations
    if (userData.bmi > 30) {
      recommendations.add(
        RecommendationItem(
          title: 'Consider a low glycemic diet for weight management',
          detail: 'High BMI may lead to insulin resistance. Reducing sugar intake and maintaining a healthy diet can help manage weight.',
        ),
      );
    } else if (userData.bmi < 18.5) {
      recommendations.add(
        RecommendationItem(
          title: 'Increase nutrient-dense food intake',
          detail: 'Low BMI may indicate nutrient deficiencies. Consider consulting a nutritionist to develop a balanced meal plan.',
        ),
      );
    } else {
      recommendations.add(
        RecommendationItem(
          title: 'Maintain a balanced diet to keep BMI in a healthy range',
          detail: 'A BMI in the healthy range reduces the risk of developing additional complications related to PCOS.',
        ),
      );
    }

    //Symptom-based recommendations
    for (String symptom in symptoms) {
      switch (symptom) {
        case 'Acne':
          recommendations.addAll([
            RecommendationItem(
              title: 'Use non-comedogenic skincare products',
              detail: 'Acne during menstruation can worsen due to hormonal changes. Gentle, non-comedogenic products help prevent clogged pores.',
            ),
            RecommendationItem(
              title: 'Reduce intake of dairy and high-sugar foods',
              detail: 'These foods can exacerbate acne due to their impact on insulin levels.',
            ),
          ]);
          break;
        case 'Headache':
          recommendations.addAll([
            RecommendationItem(
              title: 'Stay hydrated',
              detail: 'Dehydration can worsen headaches, especially during menstruation. Aim for 8-10 glasses of water per day.',
            ),
            RecommendationItem(
              title: 'Try relaxation techniques',
              detail: 'Stress-induced headaches can be alleviated with meditation or light yoga.',
            ),
          ]);
          break;
        case 'Backache':
          recommendations.addAll([
            RecommendationItem(
              title: 'Apply a warm compress to the lower back',
              detail: 'Heat therapy can help relax tense muscles and reduce pain.',
            ),
            RecommendationItem(
              title: 'Incorporate gentle stretching exercises',
              detail: 'Stretching the back can alleviate muscle tension.',
            ),
          ]);
          break;
        case 'Cramps':
          recommendations.addAll([
            RecommendationItem(
              title: 'Take magnesium supplements',
              detail: 'Magnesium helps relax the muscles, which can ease menstrual cramps.',
            ),
            RecommendationItem(
              title: 'Practice breathing exercises',
              detail: 'Deep breathing may help in pain management by reducing muscle tightness.',
            ),
          ]);
          break;
        case 'Fatigue':
          recommendations.addAll([
            RecommendationItem(
              title: 'Ensure adequate sleep (7-9 hours)',
              detail: 'Fatigue is common during periods due to hormonal fluctuations. Prioritize sleep for recovery.',
            ),
            RecommendationItem(
              title: 'Include iron-rich foods in your diet',
              detail: 'Fatigue could be a sign of low iron levels. Foods like spinach, legumes, and red meat help replenish iron.',
            ),
          ]);
          break;
        case 'Nausea':
          recommendations.addAll([
            RecommendationItem(
              title: 'Eat small, frequent meals',
              detail: 'Avoid large meals to prevent nausea during menstruation.',
            ),
            RecommendationItem(
              title: 'Consider ginger or peppermint tea',
              detail: 'These can naturally soothe the stomach and reduce nausea.',
            ),
          ]);
          break;
        case 'Breast sensitivity':
          recommendations.addAll([
            RecommendationItem(
              title: 'Wear a well-fitting, supportive bra',
              detail: 'Breast tenderness can be relieved with proper support.',
            ),
            RecommendationItem(
              title: 'Reduce caffeine intake',
              detail: 'Caffeine can increase breast tenderness, so reducing coffee and soda intake may help.',
            ),
          ]);
          break;
        case 'Hyperpigmentation':
          recommendations.addAll([
            RecommendationItem(
              title: 'Use sunscreen daily',
              detail: 'Protect skin from further darkening by wearing SPF 30 or higher.',
            ),
            RecommendationItem(
              title: 'Consider topical treatments with Vitamin C or niacinamide',
              detail: 'These ingredients can help reduce pigmentation over time.',
            ),
          ]);
          break;
        case 'Hair fall':
          recommendations.addAll([
            RecommendationItem(
              title: 'Incorporate biotin and zinc into your diet',
              detail: 'These nutrients support hair health and may reduce hair fall.',
            ),
            RecommendationItem(
              title: 'Avoid tight hairstyles',
              detail: 'Tight ponytails or buns can increase hair loss due to traction.',
            ),
          ]);
          break;
        case 'Frequent urination':
          recommendations.addAll([
            RecommendationItem(
              title: 'Monitor fluid intake',
              detail: 'While staying hydrated is important, excessive intake can contribute to frequent urination.',
            ),
            RecommendationItem(
              title: 'Check for signs of urinary tract infections (UTIs)',
              detail: 'If frequent urination is paired with discomfort, consider getting checked for a UTI.',
            ),
          ]);
          break;
        default:
          recommendations.add(
            RecommendationItem(
              title: 'Consult a healthcare professional for personalized advice',
              detail: 'For symptoms not listed or if symptoms worsen, it’s important to seek medical guidance.',
            ),
          );
      }
    }

    return recommendations;
  }
}
