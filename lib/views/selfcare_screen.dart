import 'package:flutter/material.dart';
import '../models/recommendations_model.dart';
import '/models/user_data_model.dart';


class SelfCareScreen extends StatelessWidget {
  final List<RecommendationItem> recommendations;
  final UserData userData;
  final List<String> symptoms;

  const SelfCareScreen({
    Key? key,
    required this.recommendations,
    required this.userData,
    required this.symptoms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Self-Care Recommendations')),
      body: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];
          return ListTile(
            title: Text(recommendation.title),
            subtitle: recommendation.author != null ? Text('By: ${recommendation.author}') : null,
            trailing: recommendation.buttonLabel != null
                ? TextButton(
              onPressed: () {
                if (recommendation.link != null) {
                  // launch link
                }
              },
              child: Text(recommendation.buttonLabel!),
            )
                : null,
          );
        },
      ),
    );
  }
}
