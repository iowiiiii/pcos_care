import 'package:flutter/material.dart';
import '../models/recommendations_model.dart';
import '/models/user_data_model.dart';
import '/api/recommendation_api.dart';

class SelfCareScreen extends StatefulWidget {
  final UserData userData;
  final List<String> symptoms;

  const SelfCareScreen({
    Key? key,
    required this.userData,
    required this.symptoms, required List<RecommendationItem> recommendations,
  }) : super(key: key);

  @override
  _SelfCareScreenState createState() => _SelfCareScreenState();
}

class _SelfCareScreenState extends State<SelfCareScreen> {
  List<RecommendationItem> recommendations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  Future<void> _fetchRecommendations() async {
    try {
      List<RecommendationItem> fetchedRecommendations =
      await SymptomRecommendationAPI.fetchRecommendations(
        symptoms: widget.symptoms,
        userData: widget.userData,
      );

      setState(() {
        recommendations = fetchedRecommendations;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching recommendations: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Self-Care Recommendations')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final recommendation = recommendations[index];
          return ListTile(
            title: Text(recommendation.title),
            subtitle: Text(recommendation.detail),
            trailing: recommendation.buttonLabel != null
                ? TextButton(
              onPressed: () {},
              child: Text(recommendation.buttonLabel!),
            )
                : null,
          );
        },
      ),
    );
  }
}
