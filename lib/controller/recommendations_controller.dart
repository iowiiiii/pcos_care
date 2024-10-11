import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recommendations_model.dart';

class RecommendationsController {
  final String apiUrl = 'database if online';

  Future<List<RecommendationItem>> fetchItems() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => RecommendationItem.fromJson(item)).toList(); // Cast to List<RecommendationItem>
    } else {
      throw Exception('Failed to load items');
    }
  }
}
